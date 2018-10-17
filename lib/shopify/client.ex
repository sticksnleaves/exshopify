defmodule Shopify.Client do
  @moduledoc """
  Behaviour used to implement an HTTP client.

  Shopify allows you to use the HTTP client of your choice, provided that it can
  be coerced into complying with this module's specification.
  """

  @callback request(
              method :: atom,
              url :: binary,
              headers :: [{binary, binary}],
              req_body :: binary,
              client_opts :: term
            ) ::
              {:ok, %{body: binary, status_code: pos_integer}}
              | {:error, reason :: binary}
end
