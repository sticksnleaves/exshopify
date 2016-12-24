defmodule ExShopify do
  use Application

  def start(_app, _type) do
    HTTPoison.start
    
    ExShopify.Supervisor.start_link
  end
end
