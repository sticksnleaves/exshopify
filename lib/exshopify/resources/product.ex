defmodule ExShopify.Product do
  @moduledoc """
  Individual item for sale in a Shopify store.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type product_plural :: {:ok, [%ExShopify.Product{}], %ExShopify.Meta{}}
  @type product_singular :: {:ok, %ExShopify.Product{}, %ExShopify.Meta{}}

  @plural "products"
  @singular "product"

  defstruct [:body_html, :created_at, :handle, :id, :images, :options,
             :product_type, :published_at, :published_scope, :tags,
             :template_suffix, :title, :metafields_global_title_tag,
             :metafields_global_description_tag, :updated_at, :variants,
             :vendor]

  @doc """
  Receive a count of all products.

  ## Examples

      iex> ExShopify.Product.count(session)
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, map) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, params) do
    request(:get, "/products/count.json", params, session)
    |> decode(decoder("count"))
  end

  @spec count(%ExShopify.Session{}) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session) do
    count(session, %{})
  end

  @doc """
  Create a new product.

  ## Examples

  ### Create a new product with the default variant and a product image which will be downloaded by Shopify

      iex> params = %ExShopify.Product{
      ...>   title: "Burton Custom Freestyle 151",
      ...>   body_html: "<strong>Good snowboard!</strong>",
      ...>   vendor: "Burton",
      ...>   product_type: "Snowboard",
      ...>   images: [
      ...>     %ExShopify.ProductImage{
      ...>       src: "http://example.com/elixir_logo.gif"
      ...>     }
      ...>   ]
      ...> }

      iex> ExShopify.Product.create(session, params)
      {:ok, product, meta}

  ### Create a product with a metafield

      iex> params = %ExShopify.Product{
      ...>   title: "Burton Custom Freestyle 151",
      ...>   body_html: "<strong>Good snowboard!</strong>",
      ...>   vendor: "Burton",
      ...>   product_type: "Snowboard",
      ...>   metafields: [
      ...>     %ExShopify.Metafield{
      ...>       key: "new",
      ...>       value: "newvalue",
      ...>       value_type: "string",
      ...>       namespace: "global"
      ...>     }
      ...>   ]
      ...> }

      iex> ExShopify.Product.create(session, params)
      {:ok, product, meta}

  ### Create a new product with multiple product variants

      iex> params = %ExShopify.Product{
      ...>   title: "Burton Custom Freestyle 151",
      ...>   body_html: "<strong>Good snowboard!</strong>",
      ...>   vendor: "Burton",
      ...>   product_type: "Snowboard",
      ...>   variants: [
      ...>     %ExShopify.ProductVariant{
      ...>       option1: "First",
      ...>       price: "10.00",
      ...>       sku: 123
      ...>     },
      ...>     %ExShopify.ProductVariant{
      ...>       option1: "Second",
      ...>       price: "20.00",
      ...>       sku: 123
      ...>     }
      ...>   ]
      ...> }

      iex> ExShopify.Product.create(session, params)
      {:ok, product, meta}

  ### Create a new, but unpublished product

      iex> params = %ExShopify.Product{
      ...>   title: "Burton Custom Freestyle 151",
      ...>   body_html: "<strong>Good snowboard!</strong>",
      ...>   vendor: "Burton",
      ...>   product_type: "Snowboard",
      ...>   published: false
      ...> }

      iex> ExShopify.Product.create(session, params)
      {:ok, product, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: product_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/products.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Remove a product from the database.

  ## Examples

      iex> ExShopify.Product.delete(session, 632910392)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.meta_only | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/products/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Receive a single product.

  ## Examples

      iex> ExShopify.Product.find(session, 632910392)
      {:ok, product, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: product_singular | ExShopify.Resource.error
  def find(session, id, params) do
    request(:get, "/products/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: product_singular | ExShopify.Resource.error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  Receive a list of all products.

  ## Examples

      iex> ExShopify.Product.list(session)
      {:ok, products, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: product_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/products.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: product_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Modify an existing product.

  ## Examples

  ### Update a product's title

      iex> params = %{
      ...>   title: "New product title"
      ...> }

      iex> ExShopify.Product.update(session, 632910392, params)
      {:ok, product, meta}

  ### Add a metafield to an existing product

      iex> params = %{
      ...>   metafields: [
      ...>     %{
      ...>       key: "new",
      ...>       value: "newvalue",
      ...>       value_type: "string",
      ...>       namespace: "global"
      ...>     }
      ...>   ]
      ...> }

      iex> ExShopify.Product.update(session, 632910392, params)
      {:ok, product, meta}

  ### Update a product, adding a new product image

      iex> params = %{
      ...>   images: [
      ...>     %{id: 850703190},
      ...>     %{id: 562641783},
      ...>     %{src: "http://example.com/elixir_logo.gif"}
      ...>   ]
      ...> }

      iex> ExShopify.Product.update(session, 632910392, params)
      {:ok, product, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: product_singular | ExShopify.Resource.error
  def update(session, id, params) do
    request(:put, "/products/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{
      images: [%ExShopify.ProductImage{}],
      options: [%ExShopify.ProductOption{}],
      variants: [ExShopify.ProductVariant.response_mapping]
    }
  end
end
