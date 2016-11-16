defmodule ExShopify do
  use Application

  def start(_app, _type) do
    ExShopify.Supervisor.start_link
  end
end
