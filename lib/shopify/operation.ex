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

    http_method = operation.http_method
    url = build_url(operation, session, config)
    headers = build_headers(session)
    body = build_body(operation, config)

    response = http_client.request(http_method, url, headers, body, http_client_opts)

    parse(response, config)
  end

  #
  # private
  #

  defp build_url(operation, %Shopify.Session.Private{} = session, config) do
    base_url = build_base_url(operation, session, config)

    url = Map.put(base_url, :userinfo, "#{session.api_key}:#{session.password}")

    URI.to_string(url)
  end

  defp build_url(operation, session, config) do
    URI.to_string(build_base_url(operation, session, config))
  end

  defp build_base_url(operation, session, config) do
    %URI{
      host: "#{session.shop_name}.#{config.host}",
      path: "/#{operation.path}",
      port: config.port,
      query: build_query(operation),
      scheme: config.scheme
    }
  end

  defp build_query(%{http_method: :get, params: params}) do
    URI.encode_query(params)
  end

  defp build_query(_operation) do
    nil
  end

  defp build_headers(%Shopify.Session.Public{access_token: access_token} = session)
         when not is_nil(access_token)
  do
    [{"X-Shopify-Access-Token", session.access_token}] ++ build_base_headers()
  end

  defp build_headers(_session) do
    build_base_headers()
  end

  defp build_base_headers do
    [
      {"Content-Type", "application/json"}
    ]
  end

  defp build_body(%{http_method: :get}, _config) do
    ""
  end

  defp build_body(operation, config) do
    config.json_codec.encode!(operation.params)
  end

  defp parse({:ok, %{status_code: status_code} = response}, config)
         when status_code >= 200 and status_code < 400
  do
    body = response.body

    case config.json_codec.decode(body) do
      {:error, _reason} ->
        {:ok, %{}}
      otherwise ->
        otherwise
    end
  end

  defp parse({:ok, %{status_code: status_code} = response}, config)
         when status_code >= 400
  do
    body = response.body

    case config.json_codec.decode(body) do
      {:error, _reason} ->
        {:error, %{}}
      {:ok, decoded_body} ->
        {:error, decoded_body}
    end
  end

  defp parse(response, _config) do
    response
  end
end
