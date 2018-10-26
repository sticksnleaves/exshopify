defmodule Shopify.RateLimiter.ConsumerSupervisor do
  use ConsumerSupervisor

  alias Shopify.RateLimiter

  def start_link(opts) do
    server = Keyword.fetch!(opts, :server)
    partition = Keyword.fetch!(opts, :partition)

    name = name(server, partition)

    ConsumerSupervisor.start_link(__MODULE__, opts, name: name)
  end

  def init(opts) do
    server = Keyword.get(opts, :server)
    partition = Keyword.get(opts, :partition)

    opts = [strategy: :one_for_one, subscribe_to: [{RateLimiter.Producer.name(server, partition), max_demand: 38}]]

    ConsumerSupervisor.init(children(), opts)
  end

  #
  # private
  #

  defp children do
    [
      %{
        id: RateLimiter.Consumer,
        restart: :transient,
        start: {RateLimiter.Consumer, :start_link, []}
      }
    ]
  end

  defp name(server, partition) do
    Module.concat([server, "ConsumerSupervisor:#{partition}"])
  end
end
