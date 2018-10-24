defmodule Shopify.HMAC do
  @moduledoc """
  Helper functions to verify HMAC signatures.
  """

  @doc """
  Verifies an HTTP query string passes HMAC verification.

  See `verify/3` for more details.

  ## Example
      query = "code=0907a61c0c8d55e99db179b68161bc00&hmac=4712bf92ffc2917d15a2f5a273e39f0116667419aa4b6ac0b3baaf26fa3c4d20&shop=some-shop.myshopify.com&timestamp=1337178173"
      shared_secret = "hush"

      hmac = "4712bf92ffc2917d15a2f5a273e39f0116667419aa4b6ac0b3baaf26fa3c4d20"

      {:ok, hmac} = Shopify.HMAC.verify(query, shared_secret)
  """
  @spec verify(binary, binary) :: {:ok, binary} | {:error, binary}
  def verify(query, shared_secret) do
    decoded_query = URI.decode_query(query)

    {hmac, decoded_message} = Map.pop(decoded_query, "hmac")

    message = URI.encode_query(decoded_message)

    verify(hmac, message, shared_secret)
  end

  @doc """
  Verifies the Shopify HMAC signature.

  Every request or redirect from Shopify includes an HMAC signature that can be
  used to ensure that it came from Shopify.

  This function will compute an SHA256 HMAC digest based on the provided
  `message` and `shared_secret`. The digest is then compared to the `hmac`
  signature. If they match, verification has passed. Otherwise verification
  has failed.

  ## Example
      hmac = "4712bf92ffc2917d15a2f5a273e39f0116667419aa4b6ac0b3baaf26fa3c4d20"
      message = "code=0907a61c0c8d55e99db179b68161bc00&shop=some-shop.myshopify.com&timestamp=1337178173"
      shared_secret = "hush"

      {:ok, hmac} = Shopify.HMAC.verify(hmac, message, shared_secret)
  """
  @spec verify(binary, binary, binary) :: {:ok, binary} | {:error, binary}
  def verify(hmac, message, shared_secret) do
    digest = compute_digest(message, shared_secret)

    case digest do
      ^hmac ->
        {:ok, digest}
      _otherwise ->
        {:error, digest}
    end
  end

  defp compute_digest(message, shared_secret) do
    :crypto.hmac(:sha256, shared_secret, message)
    |> Base.encode16
    |> String.downcase
  end
end
