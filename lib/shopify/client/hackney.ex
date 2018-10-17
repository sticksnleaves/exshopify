if Code.ensure_loaded?(:hackney) do
  defmodule Shopify.Client.Hackney do
    @moduledoc false

    @behaviour Shopify.Client

    def request(method, url, headers, body, client_opts) do
      opts = client_opts || [] ++ [:with_body]

      case :hackney.request(method, url, headers, body, opts) do
        {:ok, status_code, _headers} ->
          {:ok, %{body: "", status_code: status_code}}

        {:ok, status_code, _headers, body} ->
          {:ok, %{body: body, status_code: status_code}}

        error ->
          error
      end
    end
  end
end
