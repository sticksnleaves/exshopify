defmodule Shopify.RateLimiter do
  use Supervisor

  alias Shopify.RateLimiter

  #
  # client
  #

  def start_link(opts) do
    opts = Keyword.put(opts, :name, Keyword.get(opts, :name, __MODULE__))

    Supervisor.start_link(__MODULE__, opts, name: opts[:name])
  end

  def make_request(server, request, _opts) do
    partition = Map.fetch!(URI.parse(request.url), :host)

    RateLimiter.Partition.open(server, partition)
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

  defp children(opts) do
    server = opts[:name]

    [
      {RateLimiter.PartitionSupervisor, server: server},
      {RateLimiter.PartitionMonitor, server: server}
    ]
  end
end
