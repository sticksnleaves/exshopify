defmodule ExShopify.Plug do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, opts) do
    validate_opts(opts)

    cond do
      opts[:strategy] == :oauth ->
        verify_oauth(conn, opts)
      opts[:strategy] == :webhooks ->
        verify_webhooks(conn, opts)
    end
  end

  # private

  defp shared_secret(opts) do
    opts[:shared_secret] ||
    Application.get_env(:exshopify, :shared_secret)
  end

  defp validate_opts(opts) do
    strategy = opts[:strategy]

    cond do
      strategy != :oauth && strategy != :webhook ->
        raise ArgumentError, message: "ExShopify.Plug expected a strategy of :oauth or :webhook"
      shared_secret(opts) == nil ->
        raise ArgumentError, message: "ExShopify.Plug expected a shared_secret"
      true -> {}
    end
  end

  defp verify_hmac(shared_secret, message, hmac) do
    digest = :crypto.hmac(:sha256, shared_secret, message) |> Base.encode16 |> String.downcase
    hmac = String.downcase(hmac)

    digest == hmac
  end

  defp verify_oauth(conn, opts) do
    params = conn.params
    message = Map.take(params, ["code", "shop", "timestamp"]) |> URI.encode_query
    verified = verify_hmac(shared_secret(opts), message, params["hmac"])

    assign(conn, :shopify_hmac_verified, verified)
  end

  defp verify_webhooks(conn, opts) do

  end
end
