if Code.ensure_loaded?(GenStage) do
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

      RateLimiter.PartitionSupervisor.start_child(spec)
    end

    def close(server, partition) do
      name = name(server, partition)

      Supervisor.stop(name, :normal)
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

      [
        {RateLimiter.Producer, child_opts},
        {RateLimiter.ConsumerSupervisor, child_opts}
      ]
    end

    defp name(server, partition) do
      Module.concat([server, "Partition:#{partition}"])
    end
  end
end
