defmodule Shopify do
  @type response_t :: {:ok, Shopify.Response.t()} | {:error, any}

  @type session_t :: Shopify.Session.Private.t() | Shopify.Session.Public.t()

  @doc """
  Parses the shop slug from a shop domain.

  ## Example

      $> Shopify.get_slug_from_shop("johns-apparel.myshopify.com")
      #> "johns-apparel"
  """
  @spec get_slug_from_shop(binary) :: binary
  def get_slug_from_shop(shop) do
    shop
    |> String.split(".")
    |> List.first()
  end

  @doc """
  Create a session for making requests to a single store.
  """
  @spec new_private_session(binary, binary, binary) :: Shopify.Session.Private.t()
  def new_private_session(shop_name, api_key, password) do
    %Shopify.Session.Private{
      api_key: api_key,
      password: password,
      shop_name: shop_name
    }
  end

  @doc """
  Create a session for making requests to multiple stores.
  """
  @spec new_public_session(binary, binary | nil) :: Shopify.Session.Public.t()
  def new_public_session(shop_name, access_token \\ nil) do
    %Shopify.Session.Public{
      access_token: access_token,
      shop_name: shop_name
    }
  end

  @doc """
  Make a request to the Shopify API.
  """
  @spec request(Shopify.Operation.t(), session_t, map) :: response_t
  def request(operation, session, config \\ %{}) do
    Shopify.Operation.perform(operation, session, Shopify.Config.new(config))
  end
end
