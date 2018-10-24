defmodule Shopify.Client.Hackney do
  @moduledoc false

  @behaviour Shopify.Client

  def request(method, url, headers, body, client_opts) do
    opts = (client_opts || []) ++ [:with_body]

    case :hackney.request(method, url, headers, body, opts) do
      {:ok, status_code, headers} ->
        {:ok, %{body: "", headers: headers, status_code: status_code}}

      {:ok, status_code, headers, body} ->
        {:ok, %{body: body, headers: headers, status_code: status_code}}

      error ->
        error
    end
  end
end
