defmodule ExShopify.AccessToken do
  @moduledoc """
  Token used to access the Shopify API on behalf of a shop or user.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type access_token_singular :: {:ok, %ExShopify.AccessToken{}, %ExShopify.Meta{}}

  defstruct [:access_token, :scope]

  @doc """
  Trade an authorization code for an access token.

  ## Examples

      iex> ExShopify.AccessToken.create(session, "98asfd908asdf")
      {:ok, access_token, meta}
  """
  @spec create(%ExShopify.Session{}, String.t) :: access_token_singular | ExShopify.Resource.error
  def create(session, code) do
    params = %{
      client_id: session.api_key,
      client_secret: session.secret,
      code: code
    }

    request(:post, "/oauth/access_token", params, session)
    |> decode(&access_token_decoder/1)
  end

  # private

  defp access_token_decoder(body) do
    Poison.decode!(body, as: %__MODULE__{})
  end
end
