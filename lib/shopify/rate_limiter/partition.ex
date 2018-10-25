defmodule Shopify.RateLimiter.Partition do
  use Supervisor, restart: :temporary

  alias Shopify.RateLimiter

  #
  # client
  #

  def start_link(opts) do
    server = Keyword.fetch!(opts, :server)
    partition = Keyword.fetch!(opts, :partition)

    name = name(server, partition)

    Supervisor.start_link(__MODULE__, opts, name: name)
  end

  def open(server, partition) do
    spec = {__MODULE__, server: server, partition: partition}

    {:ok, _pid} = RateLimiter.PartitionSupervisor.start_child(spec)

    :ok = RateLimiter.PartitionMonitor.monitor(server, partition)
  end

  def close(server, partition) do

  end

  #
  # callbacks
  #

  def init(opts) do
    Supervisor.init(children(opts), strategy: :one_for_one)
  end

  #
  # private
  #

  def children(opts) do
    child_opts = Keyword.take(opts, [:server, :partition])

    []
  end

  defp name(server, partition) do
    Module.concat([server, "Partition:#{partition}"])
  end
end
