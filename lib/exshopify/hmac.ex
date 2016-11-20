defmodule ExShopify.HMAC do
  @moduledoc """
  Module for handling Shopify HMAC signatures.
  """

  @doc """
  Verifies the Shopify HMAC signature.

  Every request or redirect from Shopify includes an HMAC signature that can be
  used to ensure that it came from Shopify.

  This function will compute an SHA256 HMAC digest based on the provided
  `message` and `shared_secret`. The digest is then compared to the `hmac`
  signature. If they match, verification has passed. Otherwise verification
  has failed.
  """
  @spec verify(String.t, String.t, String.t) :: {:ok | :error, String.t}
  def verify(hmac, message, shared_secret) do
    digest = compute_digest(message, shared_secret)

    case digest do
      ^hmac -> {:ok, digest}
      _     -> {:error, digest}
    end
  end

  # private

  defp compute_digest(message, shared_secret) do
    :crypto.hmac(:sha256, shared_secret, message)
    |> Base.encode16
    |> String.downcase
  end
end
