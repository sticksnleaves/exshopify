defmodule ExShopify.Collect do
  @moduledoc """
  Connects a product to a custom collection.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type collect_count :: {:ok, integer, %ExShopify.Meta{}}
  @type collect_plural :: {:ok, [%ExShopify.Collect{}], %ExShopify.Meta{}}
  @type collect_singular :: {:ok, %ExShopify.Collect{}, %ExShopify.Meta{}}

  @plural "collects"
  @singular "collect"

  defstruct [:collection_id, :created_at, :featured, :id, :position,
             :product_id, :sort_value, :updated_at]

  @doc """
  Get a count of all collects or only those for specific products or
  collections.

  ## Examples

  ### Count all collects for your shop

      iex> ExShopify.Collect.count(session)
      {:ok, count, meta}

  ### Count only collects for a certain collection

      iex> ExShopify.Collect.count(session, %{collection_id: 841564295})
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, map) :: collect_count | ExShopify.Resource.error
  def count(session, params) do
    request(:get, "/collects/count.json", params, session)
    |> decode(decoder("count"))
  end

  @spec count(%ExShopify.Session{}) :: collect_count | ExShopify.Resource.error
  def count(session) do
    count(session, %{})
  end

  @doc """
  Add a product to a collection.

  ## Examples

      iex> params = %ExShopify.Collect{
      ...>   product_id: 921728736,
      ...>   collection_id: 841564295
      ...> }

      iex> ExShopify.Collect.create(session, params)
      {:ok, collect, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: collect_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/collects.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Remove a product from a collection.

  ## Examples

      iex> ExShopify.Collect.delete(session, 841564295)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: collect_singular | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/collects/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Get the collect with a certain id, or for a given product AND collection.

  ## Examples

      iex> ExShopify.Collect.find(session, 841564295)
      {:ok, collect, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t) :: collect_singular | ExShopify.Resource.error
  def find(session, id) do
    request(:get, "/collects/#{id}.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  List all collects or only those for specific products or collections.

  ## Examples

  ### List all collects for your shop

      iex> ExShopify.Collect.list(session)
      {:ok, collects, meta}

  ### List only collects for a certain product

      iex> ExShopify.Collect.list(session, %{product_id: 632910392})
      {:ok, collects, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: collect_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/collects.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: collect_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
