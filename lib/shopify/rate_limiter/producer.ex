defmodule Shopify.RateLimiter.Producer do
  use GenStage

  alias Shopify.RateLimiter

  #
  # client
  #

  def name(server, partition) do
    Module.concat([server, "Producer:#{partition}"])
  end

  def queue_request(server, partition, request, opts) do
    name = name(server, partition)

    GenStage.call(name, {:queue_request, request, opts}, :infinity)
  end

  def reschedule_event(event) do
    GenServer.cast(event.producer, {:reschedule_event, event})
  end

  def start_link(opts) do
    server = Keyword.fetch!(opts, :server)
    partition = Keyword.fetch!(opts, :partition)

    name = name(server, partition)

    GenStage.start_link(__MODULE__, opts, name: name)
  end

  #
  # callbacks
  #

  def init(opts) do
    server = Keyword.get(opts, :server)
    partition = Keyword.get(opts, :partition)

    state = %{
      capacity: 38,
      partition: partition,
      pending_demand: 38,
      queue: :queue.new(),
      server: server
    }

    schedule_cooldown()

    {:producer, state}
  end

  def handle_call({:queue_request, request, opts}, from, state) do
    RateLimiter.PartitionMonitor.keep_partition_alive(state.server, state.partition)

    event = %RateLimiter.Event{
              producer: self(),
              opts: opts,
              owner: from,
              request: request
            }

    state = Map.put(state, :queue, :queue.in(event, state.queue))

    process_demand(state)
  end

  def handle_cast({:reschedule_event, event}, state) do
    state = Map.put(state, :queue, :queue.in(event, state.queue))

    {:noreply, [], state}
  end

  def handle_demand(demand, state) do
    {:noreply, [], Map.put(state, :pending_demand, demand)}
  end

  def handle_info(:cooldown, state) do
    schedule_cooldown()

    capacity =
      if state.capacity > 37 do
        39
      else
        state.capacity + 2
      end

    state = Map.put(state, :capacity, capacity)

    process_demand(state)
  end

  #
  # private
  #

  defp amount_to_dispatch(demand, capacity) do
    if demand > capacity do
      capacity
    else
      demand
    end
  end

  defp collect_events_to_dispatch(queue, 0, acc) do
    {Enum.reverse(acc), queue}
  end

  defp collect_events_to_dispatch(queue, amount_to_dispatch, acc) do
    case :queue.out(queue) do
      {{:value, event}, queue} ->
        collect_events_to_dispatch(queue, amount_to_dispatch - 1, [event | acc])
      {:empty, queue} ->
        collect_events_to_dispatch(queue, 0, acc)
    end
  end

  defp process_demand(state) do
    %{
      capacity: capacity,
      partition: partition,
      pending_demand: pending_demand,
      queue: queue,
      server: server
    } = state

    amount_possible_to_dispatch = amount_to_dispatch(:queue.len(queue), capacity)
    amount_to_dispatch = amount_to_dispatch(pending_demand, amount_possible_to_dispatch)

    {to_dispatch, remaining} = collect_events_to_dispatch(queue, amount_to_dispatch, [])

    if length(to_dispatch) > 0, do: RateLimiter.PartitionMonitor.keep_partition_alive(server, partition)

    state =
      state
      |> Map.put(:capacity, capacity - amount_to_dispatch)
      |> Map.put(:pending_demand, pending_demand - amount_to_dispatch)
      |> Map.put(:queue, remaining)

    {:noreply, to_dispatch, state}
  end

  defp schedule_cooldown do
    Process.send_after(self(), :cooldown, 1000)
  end
end
