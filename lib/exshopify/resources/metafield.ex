defmodule ExShopify.Metafield do
  @moduledoc """
  Additional metadata to a store's resources.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type metafield_plural :: {:ok, [%ExShopify.Metafield{}], %ExShopify.Meta{}}
  @type metafield_singular :: {:ok, %ExShopify.Metafield{}, %ExShopify.Meta{}}

  @plural "metafields"
  @singular "metafield"

  defstruct [:created_at, :description, :id, :key, :namespace, :owner_id,
             :owner_resource, :updated_at, :value, :value_type]

  @doc """
  Get a count of metafields that belong to a store.

  ## Examples

      iex> ExShopify.Metafield.count(session)
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session) do
    request(:get, "/metafields/count.json", %{}, session)
    |> decode(decoder("count"))
  end

  @doc """
  Get a count of metafields that belong to a product.

  ## Examples

      iex> ExShopify.Metafield.count(session, 632910392)
      {:ok, count, meta}
  """
  @spec count_from_product(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count_from_product(session, product_id) do
    request(:get, "/products/#{product_id}/metafields/count.json", %{}, session)
    |> decode(decoder("count"))
  end

  @doc """
  Delete a store metafield.

  ## Examples

      iex> ExShopify.Metafield.delete(session, 721389482)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.only_meta | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/metafields/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Delete a product metafield.

  ## Examples

      iex> ExShopify.Metafield.delete_from_product(session, 845366454, 632910392)
      {:ok, meta}
  """
  @spec delete_from_product(%ExShopify.Session{}, integer | String.t, integer | String.t) :: ExShopify.Resource.only_meta | ExShopify.Resource.error
  def delete_from_product(session, id, product_id) do
    request(:delete, "/products/#{product_id}/metafields/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Create a new metafield for a store.

  ## Examples

      iex> params = %ExShopify.Metafield{
      ...>   namespace: "inventory",
      ...>   key: "warehouse",
      ...>   value: 25,
      ...>   value_type: "integer"
      ...> }

      iex> ExShopify.Metafield.create(session, params)
      {:ok, metafield, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: metafield_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/metafields.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Create a new metafield for a product.

  ## Examples

      iex> params = %ExShopify.Metafield{
      ...>   namespace: "inventory",
      ...>   key: "warehouse",
      ...>   value: 25,
      ...>   value_type: "integer"
      ...> }

      iex> ExShopify.Metafield.create_from_product(session, 632910392, params)
      {:ok, metafield, meta}
  """
  @spec create_from_product(%ExShopify.Session{}, integer | String.t, map) :: metafield_singular | ExShopify.Resource.error
  def create_from_product(session, product_id, params) do
    request(:post, "/products/#{product_id}/metafields.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Get a single store metafield by its id.

  ## Examples

      iex> ExShopify.Metafield.find(session, 721389482)
      {:ok, metafield, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t) :: metafield_singular | ExShopify.Resource.error
  def find(session, id) do
    request(:get, "/metafields/#{id}.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Get a single product metafield by its id.

  ## Examples

      iex> ExShopify.Metafield.find_from_product(session, 845366454, 632910392)
      {:ok, metafield, meta}
  """
  @spec find_from_product(%ExShopify.Session{}, integer | String.t, integer | String.t) :: metafield_singular | ExShopify.Resource.error
  def find_from_product(session, id, product_id) do
    request(:get, "/products/#{product_id}/metafields/#{id}.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Get metafields that belong to a store.

  ## Examples

  ### Get all metafields that belong to a store

      iex> ExShopify.Metafield.list(session)
      {:ok, metafields, meta}

  ### Get metafields that belong to a product image

      iex> params = %{
      ...>   metafield: %{
      ...>     owner_id: 850703190,
      ...>     owner_resource: "product_image"
      ...>   }
      ...> }

      iex> ExShopify.Metafield.list(session, params)
  """
  @spec list(%ExShopify.Session{}, map) :: metafield_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/metafields.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: metafield_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Get metafields that belong to a product.

  ## Examples

      iex> ExShopify.Metafield.list_from_product(session, 632910392)
      {:ok, metafields, meta}
  """
  @spec list_from_product(%ExShopify.Session{}, integer | String.t) :: metafield_plural | ExShopify.Resource.error
  def list_from_product(session, product_id) do
    request(:get, "/products/#{product_id}/metafields.json", %{}, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @doc """
  Update a store metafield.

  ## Examples

      iex> params = %{value: "something new", value_type: "string"}

      iex> ExShopify.Metafield.update(session, 721389482, params)
      {:ok, metafield, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: metafield_plural | ExShopify.Resource.error
  def update(session, id, params) do
    request(:put, "/metafields/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Update a product metafield.

  ## Examples

  iex> params = %{value: "something new", value_type: "string"}

  iex> ExShopify.Metafield.update_from_product(session, 845366454, 632910392, params)
  {:ok, metafield, meta}
  """
  @spec update_from_product(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: metafield_singular | ExShopify.Resource.error
  def update_from_product(session, id, product_id, params) do
    request(:put, "/products/#{product_id}/metafields/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
