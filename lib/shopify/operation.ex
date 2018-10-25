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
    response =
      %Shopify.Response{
        body: parse_body(response.body, config),
        headers: response.headers,
        status_code: status_code
      }

    {:ok, response}
  end

  defp handle_response(%{status_code: status_code} = response, config)
       when status_code >= 400
  do
    response =
      %Shopify.Response{
        body: parse_body(response.body, config),
        headers: response.headers,
        status_code: status_code
      }

    {:error, response}
  end

  defp parse_body(raw_body, config) do
    case config.json_codec.decode(raw_body) do
      {:ok, body} ->
        body
      {:error, _reason} ->
        %{}
    end
  end
end
