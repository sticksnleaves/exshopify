defmodule Shopify.RateLimiter.PartitionSupervisor do
  use DynamicSupervisor

  #
  # client
  #

  def start_child(spec) do
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def start_link(opts) do
    server = Keyword.fetch!(opts, :server)

    IO.inspect server

    name = name(server)

    DynamicSupervisor.start_link(__MODULE__, :ok, name: name)
  end

  #
  # callbacks
  #

  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  #
  # private
  #

  defp name(server) do
    Module.concat([server, PartitionSupervisor])
  end
end
