defmodule ExShopify.ProductVariant do
  @moduledoc """
  Different version of a product.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type product_variant_plural :: {:ok, [%ExShopify.ProductVariant{}], %ExShopify.Meta{}}
  @type product_variant_singular :: {:ok, %ExShopify.ProductVariant{}, %ExShopify.Meta{}}

  @plural "variants"
  @singular "variant"

  defstruct [:barcode, :compare_at_price, :created_at, :fulfillment_service,
             :grams, :id, :image_id, :inventory_management, :inventory_policy,
             :inventory_quantity, :old_inventory_quantity,
             :inventory_quantity_adjustment, :metafields, :option1, :option2,
             :option3, :position, :price, :product_id, :requires_shipping, :sku,
             :taxable, :title, :updated_at, :weight, :weight_unit]

  @doc """
  Receive a count of all product variants.

  ## Examples

      iex> ExShopify.ProductVariant.count(session, 632910392)
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, product_id) do
    request(:get, "/products/#{product_id}/variants/count.json", %{}, session)
    |> decode(decoder("count"))
  end

  @doc """
  Create a new product variant.

  ## Examples

  ### Create a product variant

      iex> params = %{
      ...>   option1: "Yellow",
      ...>   price: "1.00"
      ...> }

      iex> ExShopify.ProductVariant.create(session, params)
      {:ok, product_variant, meta}

  ### Create a new product variant with a metafield

      iex> params = %{
      ...>   option1: "Blue",
      ...>   metafields: [
      ...>     %{
      ...>       key: "new",
      ...>       value: "newvalue",
      ...>       value_type: "string",
      ...>       namespace: "global"
      ...>     }
      ...>   ]
      ...> }

      iex> ExShopify.ProductVariant.create(session, params)
      {:ok, product_variant, meta}

  ### Create a new product variant with an image

      iex> params = %{
      ...>   option1: "Blue",
      ...>   image_id: 850703190
      ...> }

      iex> ExShopify.ProductVariant.create(session, params)
      {:ok, product_variant, meta}
  """
  @spec create(%ExShopify.Session{}, integer | String.t, map) :: product_variant_singular | ExShopify.Resource.error
  def create(session, product_id, params) do
    request(:post, "/products/#{product_id}/variants.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Delete a product variant.

  ## Examples

      iex> ExShopify.ProductVariant.delete(session, 808950810, 632910392)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t, integer | String.t) :: ExShopify.Resource.meta_only | ExShopify.Resource.error
  def delete(session, id, product_id) do
    request(:delete, "/products/#{product_id}/variants/#{id}.json", %{}, session)
  end

  @doc """
  Receive a single product variant.

  ## Examples

      iex> ExShopify.ProductVariant.find(session, 808950810)
      {:ok, product_variant, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: product_variant_singular | ExShopify.Resource.error
  def find(session, id, params) do
    request(:get, "/variants/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: product_variant_singular | ExShopify.Resource.error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  Receive a list of all product variants.

  ## Examples

      iex> ExShopify.ProductVariant.list(session, 632910392)
      {:ok, product_variants, meta}
  """
  @spec list(%ExShopify.Session{}, integer | String.t, map) :: product_variant_plural | ExShopify.Resource.error
  def list(session, product_id, params) do
    request(:get, "/products/#{product_id}/variants.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}, integer | String.t) :: product_variant_plural | ExShopify.Resource.error
  def list(session, product_id) do
    list(session, product_id, %{})
  end

  @doc """
  Modify an existing product variant.

  ## Examples

  ### Update a variant's inventory

      iex> params = %{
      ...>   inventory_quantity: 100,
      ...>   old_inventory_quantity: 10
      ...> }

      iex> ExShopify.ProductVariant.update(session, 808950810, params)
      {:ok, product_variant, meta}

  ### Add a metafield to an existing variant

      iex> params = %{
      ...>   metafields: [
      ...>     key: "new",
      ...>     value: "newvalue",
      ...>     value_type: "string",
      ...>     namespace: "global"
      ...>   ]
      ...> }

      iex> ExShopify.ProductVariant.update(session, 808950810, params)
      {:ok, product_variant, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: product_variant_singular | ExShopify.Resource.error
  def update(session, id, params) do
    request(:put, "/variants/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{
      metafields: [%ExShopify.Metafield{}]
    }
  end
end
