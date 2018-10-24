defmodule Shopify.Client do
  @moduledoc """
  Behaviour used to implement an HTTP client.

  Shopify allows you to use the HTTP client of your choice, provided that it can
  be coerced into complying with this module's specification.
  """

  @callback request(request :: Shopify.Request.t(), client_opts :: term) ::
              {:ok, Shopify.Client.Response.t()} | {:error, reason :: binary}
end
