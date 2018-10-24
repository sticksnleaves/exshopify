defmodule Shopify.Client.Hackney do
  @moduledoc false

  @behaviour Shopify.Client

  def request(request, client_opts) do
    opts = (client_opts || []) ++ [:with_body]

    response = :hackney.request(request.method, request.url, request.headers, request.body, opts)

    serialize_response(response)
  end

  defp serialize_response({:ok, status_code, headers}) do
    response =
      %Shopify.Client.Response{
        headers: headers,
        status_code: status_code
      }

    {:ok, response}
  end

  defp serialize_response({:ok, status_code, headers, body}) do
    response =
      %Shopify.Client.Response{
        body: body,
        headers: headers,
        status_code: status_code
      }

    {:ok, response}
  end

  defp serialize_response(otherwise) do
    otherwise
  end
end
