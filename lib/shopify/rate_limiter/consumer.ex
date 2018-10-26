defmodule Shopify.RateLimiter.Consumer do
  alias Shopify.RateLimiter

  def start_link(event) do
    Task.start_link(fn ->
      attempts = Map.get(event, :attempts) + 1

      event = Map.put(event, :attempts, attempts)

      {http_client, http_client_opts} = Keyword.fetch!(event.opts, :http_client)

      case http_client.request(event.request, http_client_opts) do
        {:ok, %{status_code: 429}} ->
          RateLimiter.Producer.reschedule_event(event)
        response ->
          GenStage.reply(event.owner, response)
      end
    end)
  end
end
