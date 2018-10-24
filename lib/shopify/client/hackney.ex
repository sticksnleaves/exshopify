defmodule Shopify.Client.Hackney do
  @moduledoc false

  @behaviour Shopify.Client

  def request(method, url, headers, body, client_opts) do
    opts = (client_opts || []) ++ [:with_body]

    response = :hackney.request(method, url, headers, body, opts)

    serialize_response(response)
  end

  defp serialize_response({:ok, status_code, headers}) do
    %Shopify.Client.Response{
      headers: headers,
      status_code: status_code
    }
  end

  defp serialize_response({:ok, status_code, headers, body}) do
    %Shopify.Client.Response{
      body: body,
      headers: headers,
      status_code: status_code
    }
  end

  defp serialize_response(otherwise) do
    otherwise
  end
end
