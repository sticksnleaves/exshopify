defmodule Shopify.Request do
  @type t :: %__MODULE__{
    body: binary,
    headers: [{binary, binary}],
    method: atom,
    url: binary
  }

  defstruct body: "",
            headers: [],
            method: nil,
            url: nil

@default_headers [{"content-type", "application/json"}]

  def new(operation, session, config) do
    %__MODULE__{
      body: encode_body(operation, config),
      headers: build_headers(session),
      method: operation.http_method,
      url: build_url(operation, session, config)
    }
  end

  defp encode_body(%{http_method: :get}, _config) do
    ""
  end

  defp encode_body(%{params: params}, config) do
    case config.json_codec.encode(params) do
      {:ok, body} ->
        body
      {:error, _reason} ->
        ""
    end
  end

  defp build_headers(%Shopify.Session.Public{access_token: access_token}) do
    [{"x-shopify-access-token", access_token}] ++ @default_headers
  end

  defp build_headers(%Shopify.Session.Private{ api_key: api_key, password: password }) do
    token = Base.encode64("#{api_key}:#{password}")

    [{"authorization", "Basic #{token}"}] ++ @default_headers
  end

  defp build_url(operation, session, config) do
    %URI{
      host: "#{session.shop_name}.#{config.host}",
      port: config.port,
      scheme: config.scheme
    }
    |> put_path(operation, config)
    |> put_query(operation)
    |> URI.to_string()
    |> IO.inspect()
  end

  defp put_path(uri, operation, %{ version: version } = config) when not is_nil(version) do
    IO.inspect config
    Map.put(uri, :path, "/admin/api/#{config.version}#{operation.path}")
  end

  defp put_path(uri, operation, config) do
    IO.inspect config
    Map.put(uri, :path, "/admin#{operation.path}")
  end

  defp put_query(uri, %{http_method: :get, params: params}) do
    Map.put(uri, :query, URI.encode_query(params))
  end

  defp put_query(uri, _operation) do
    uri
  end
end
