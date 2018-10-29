defmodule Shopify.Client.RateLimit do
  def request(request, client_opts) do
    server = Keyword.get(client_opts, :name, Shopify.RateLimiter)

    opts = Keyword.take(client_opts, [:http_client])

    Shopify.RateLimiter.make_request(server, request, opts)
  end
end
