defmodule ExShopify.API do
  @moduledoc """
  Module for working with Shopify API requests.
  """

  @doc """
  Make a request to the Shopify API.
  """
  def request(method, path, params, session) do
    session = session || ExShopify.Session.new

    req_body    = req_body(method, params)
    req_headers = req_headers(session)
    req_url     = req_url(method, path, params, session)

    HTTPoison.request(method, req_url, req_body, req_headers)
  end

  # private

  defp build_url(session) do
    protocol  = session.protocol
    domain    = session.domain
    port      = session.port
    shop_name = session.shop_name

    url = "#{protocol}://#{shop_name}.#{domain}"

    url =
      cond do
        port -> url <> ":#{port}"
        true -> url
      end

    url <> "/admin"
  end

  defp req_body(method, params) do
    case method do
      :get -> ""
      _    -> Poison.encode!(params)
    end
  end

  defp req_headers(session) do
    access_token = session.access_token
    headers      = [{"Content-Type", "application/json; charset=utf-8"}]

    cond do
      access_token -> headers ++ [{"X-Shopify-Access-Token", access_token}]
      true         -> headers
    end
  end

  defp req_url(method, path, params, session) do
    url =
      session.shop_url ||
      build_url(session)

    url = url <> path

    cond do
      method in [:delete, :get] -> url <> "?#{ExShopify.URI.encode_query(params)}"
      true                      -> url
    end
  end
end
