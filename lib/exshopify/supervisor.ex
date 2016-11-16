defmodule ExShopify.Supervisor do
  use Supervisor

  # client

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  # callbacks

  def init(:ok) do
    supervise(children, strategy: :one_for_one)
  end

  # private

  defp children do
    [

    ]
  end
end
