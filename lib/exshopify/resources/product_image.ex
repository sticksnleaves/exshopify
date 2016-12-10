defmodule ExShopify.ProductImage do
  @moduledoc """
  Images of a product.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type product_image_plural :: {:ok, [%ExShopify.ProductImage{}], %ExShopify.Meta{}}
  @type product_image_singular :: {:ok, %ExShopify.ProductImage{}, %ExShopify.Meta{}}

  @plural "images"
  @singular "image"

  defstruct [:created_at, :id, :position, :product_id, :variant_ids, :src,
             :updated_at]

  @doc """
  Receive a count of all product images.

  ## Examples

      iex> ExShopify.ProductImage.count(session, 632910392)
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, integer | String.t, map) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, product_id, params) do
    request(:get, "/products/#{product_id}/images/count.json", params, session)
    |> decode(decoder("count"))
  end

  @spec count(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, product_id) do
    count(session, product_id, %{})
  end

  @doc """
  Create a new product image.

  ## Examples

  ### Create a new product image using a source URL that will be downloaded by Shopify

      iex> params = %{
      ...>   src: "http://example.com/elixir_logo.gif"
      ...> }

      iex> ExShopify.ProductImage.create(session, 632910392, params)
      {:ok, product_image, meta}

  ### Create a new product image and attach it to product variants

      iex> params = %{
      ...>   variant_ids: [808950810, 457924702]
      ...>   attachment: Base.encode64(File.read("path/to/image.png"))
      ...> }

      iex> ExShopify.ProductImage.create(session, 632910392, params)
      {:ok, product_image, meta}
  """
  @spec create(%ExShopify.Session{}, integer | String.t, map) :: product_image_singular | ExShopify.Resource.error
  def create(session, product_id, params) do
    request(:post, "/products/#{product_id}/images.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Remove a product image from the database.

  ## Examples

      iex> ExShopify.ProductImage.delete(session, 850703190, 632910392)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t, integer | String.t) :: ExShopify.Resource.meta_only | ExShopify.Resource.error
  def delete(session, id, product_id) do
    request(:delete, "/products/#{product_id}/images/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Receive a single product image.

  ## Examples

      iex> ExShopify.ProductImage.find(session, 850703190, 632910392)
      {:ok, product_image, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: product_image_singular | ExShopify.Resource.error
  def find(session, id, product_id, params) do
    request(:get, "/products/#{product_id}/images/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t) :: product_image_singular | ExShopify.Resource.error
  def find(session, id, product_id) do
    find(session, id, product_id, %{})
  end

  @doc """
  Receive a list of all product images.

  ## Examples

      iex> ExShopify.ProductImage.list(session, 632910392)
      {:ok, product_images, meta}
  """
  @spec list(%ExShopify.Session{}, integer | String.t, map) :: product_image_plural | ExShopify.Resource.error
  def list(session, product_id, params) do
    request(:get, "/products/#{product_id}/images.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}, integer | String.t) :: product_image_plural | ExShopify.Resource.error
  def list(session, product_id) do
    list(session, product_id, %{})
  end

  @doc """
  Modify an existing product image.

  ## Examples

      iex> params = %{
      ...>   position: 2,
      ...>   metafields: [
      ...>     key: "alt",
      ...>     value: "new alt tag content",
      ...>     value_type: "string",
      ...>     namespace: "tags"
      ...>   ]
      ...> }

      iex> ExShopify.ProductImage.update(session, 850703190, 632910392, params)
      {:ok, product_image, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: product_image_singular | ExShopify.Resource.error
  def update(session, id, product_id, params) do
    request(:put, "/products/#{product_id}/images/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
