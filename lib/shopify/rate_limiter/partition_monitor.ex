defmodule Shopify.RateLimiter.PartitionMonitor do
  use GenServer

  alias Shopify.RateLimiter

  @default_timeout 25000

  #
  # client
  #

  def start_link(opts) do
    server = Keyword.fetch!(opts, :server)

    name = name(server)

    GenServer.start_link(__MODULE__, %{}, name: name)
  end

  def monitor(server, partition) do
    name = name(server)

    GenServer.call(name, {:monitor, {server, partition}})
  end

  #
  # callbacks
  #

  def init(state) do
    state = Map.merge(state, %{timers: %{}})

    {:ok, state}
  end

  def handle_call({:monitor, id}, _from, %{timers: timers} = state) do
    cancel_shutdown(Map.get(timers, id))

    timer = Process.send_after(self(), {:shutdown, id}, @default_timeout)

    timers = Map.put(timers, id, timer)

    state = Map.put(state, :timers, timers)

    {:reply, :ok, state}
  end

  defp cancel_shutdown(nil) do
    nil
  end

  defp cancel_shutdown(ref) do
    Process.cancel_timer(ref)
  end

  def handle_info({:shutdown, {server, partition} = id}, %{timers: timers} = state) do
    RateLimiter.Partition.close(server, partition)

    timers = Map.delete(timers, id)

    state = Map.put(state, :timers, timers)

    {:noreply, state}
  end

  #
  # private
  #

  defp name(server) do
    Module.concat([server, PartitionMonitor])
  end
end
