defmodule Shopify.Operation do
  @type t :: %__MODULE__{
               http_method: atom,
               params: map,
               path: binary
             }

  defstruct http_method: nil,
            params: %{},
            path: nil

  @spec perform(t, Shopify.session_t(), Shopify.Config.t()) :: Shopify.response_t()
  def perform(operation, session, config) do
    {http_client, http_client_opts} = config.http_client

    request = Shopify.Request.new(operation, session, config)

    case http_client.request(request, http_client_opts) do
      {:ok, response} ->
        handle_response(response, config)
      otherwise ->
        otherwise
    end
  end

  defp handle_response(%{status_code: status_code} = response, config)
       when status_code >= 200 and status_code < 400
  do
    {:ok, parse_body(response.body, config), build_meta(response.headers)}
  end

  defp handle_response(%{status_code: status_code} = response, config)
       when status_code >= 400
  do
    {:error, parse_body(response.body, config)}
  end

  defp parse_body(raw_body, config) do
    case config.json_codec.decode(raw_body) do
      {:ok, body} ->
        body
      {:error, _reason} ->
        %{}
    end
  end

  defp build_meta(headers) do
    Enum.reduce(headers, %Shopify.Meta{}, fn({k, v}, acc) ->
      case String.downcase(k) do
        "x-shopify-shop-api-call-limit" ->
          parts = String.split(v, "/")

          count =
            parts
            |> Enum.at(0)
            |> String.to_integer()

          limit =
            parts
            |> Enum.at(1)
            |> String.to_integer()

          Map.put(acc, :api_call_limit, {count, limit})
        _otherwise ->
          acc
      end
    end)
  end
end
