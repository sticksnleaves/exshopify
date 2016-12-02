defmodule ExShopify.CustomCollection do
  @moduledoc """
  Reader's response to an article in a blog.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type custom_collection_plural :: {:ok, [%ExShopify.CustomCollection{}], %ExShopify.Meta{}}
  @type custom_collection_singular :: {:ok, %ExShopify.CustomCollection{}, %ExShopify.Meta{}}

  @plural "custom_collections"
  @singular "custom_collection"

  defstruct [:body_html, :handle, :image, :id, :metafields, :published,
             :published_at, :published_scope, :sort_order, :template_suffix,
             :title, :updated_at]

  @doc """
  Get a count of all custom collections that contain a given product.

  ## Examples

  ### Count all collections

      iex> ExShopify.CustomCollection.count(session)
      {:ok, count, meta}

  ### Count all custom collections for a certain product_id

      iex> ExShopify.CustomCollection.count(session, %{product_id: 632910392})
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, map) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, params) do
    request(:get, "/custom_collections/count.json", params, session)
    |> decode(decoder("count"))
  end

  @spec count(%ExShopify.Session{}) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session) do
    count(session, %{})
  end

  @doc """
  Create a new custom collection.

  ## Examples

  ### Create a collection with title Macbooks

      iex> params = %ExShopify.CustomCollection{title: "Macbooks"}

      iex> ExShopify.CustomCollection.create(session, params)
      {:ok, custom_collection, meta}

  ### Create a new, but unpublished collection

      iex> params = %ExShopify.CustomCollection{
      ...>   title: "Macbooks",
      ...>   published: false
      ...> }

      iex> ExShopify.CustomCollection.create(session, params)
      {:ok, custom_collection, meta}

  ### Create a new collection with an image which will be downloaded by Shopify

      iex> params = %ExShopify.CustomCollection{
      ...>   title: "Macbooks",
      ...>   image: %{
      ...>     src: "http://example.com/rails_logo.gif"
      ...>   }
      ...> }

      iex> ExShopify.CustomCollection.create(session, params)
      {:ok, custom_collection, meta}

  ### Create a new collection with a base64 encoded image

      iex> params = %ExShopify.CustomCollection{
      ...>   title: "Macbooks",
      ...>   image: %{
      ...>     attachment: Base.encode64(File.read("path/to/image.png"))
      ...>   }
      ...> }

      iex> ExShopify.CustomCollection.create(session, params)
      {:ok, custom_collection, meta}

  ### Create a collection with a collect

      iex> params = %ExShopify.CustomCollection{
      ...>   title: "Macbooks",
      ...>   collects: [
      ...>     %ExShopify.Collection{product_id: "921728736"}
      ...>   ]
      ...> }

      iex> ExShopify.CustomCollection.create(session, params)
      {:ok, custom_collection, meta}

  ### Create a collection with a metafield

      iex> params = %ExShopify.CustomCollection{
      ...>   title: "Macbooks",
      ...>   metafields: [
      ...>     %ExShopify.Metafield{
      ...>       key: "new",
      ...>       value: "newvalue",
      ...>       value_type: "string",
      ...>       namespace: "global"
      ...>     }
      ...>   ]
      ...> }

      iex> ExShopify.CustomCollection.create(session, params)
      {:ok, custom_collection, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: custom_collection_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/custom_collections.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Remove custom collection.

  ## Examples

      iex> ExShopify.CustomCollection.delete(session, 841564295)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.only_meta | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/custom_collections/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Get a single custom collection.

  ## Examples

      iex> ExShopify.CustomCollection.find(session, 841564295)
      {:ok, custom_collection, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: custom_collection_singular | ExShopify.Resource.error
  def find(session, id, params) do
    request(:get, "/custom_collections/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: custom_collection_singular | ExShopify.Resource.error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  Get a list of all custom collections that contain a given product.

  ## Examples

  ### List all collections

      iex> ExShopify.CustomCollection.list(session)
      {:ok, custom_collections, meta}

  ### List all custom collections for a certain product_id

      iex> ExShopify.CustomCollection.list(session, %{product_id: 632910392})
      {:ok, custom_collections, meta}

  ### Get a list of specific custom collections

      iex> ExShopify.CustomCollection.list(session, %{ids: [395646240, 691652237, 841564295]})
      {:ok, custom_collections, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: custom_collection_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/custom_collections.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: custom_collection_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Update an existing custom collection.

  ## Examples

  ### Change the description of a collection

      iex> params = %{body_html: "<p>5000 songs in your pocket</p>"}

      iex> ExShopify.CustomCollection.update(session, 841564295, params)
      {:ok, custom_collection, meta}

  ### Add a collect to an existing collection and update the sort value of the existing collect

  Use `product_id` for products being added to the collection, and id for products that were already in the collection.

      iex> params = %{
      ...>   collects: [
      ...>     %{product_id: 921728736, sort_value: "0000000001"},
      ...>     %{id: 841564295, sort_value: "0000000002"}
      ...>   ]
      ...> }

      iex> ExShopify.CustomCollection.update(session, 841564295, params)
      {:ok, custom_collection, meta}

  ### Update a collection, clearing the collection image

      iex> params = %{image: ""}

      iex> ExShopify.CustomCollection.update(session, 841564295, params)
      {:ok, custom_collection, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: custom_collection_singular | ExShopify.Resource.error
  def update(session, id, params) do
    request(:put, "/custom_collections/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %ExShopify.CustomCollection{
      metafields: [%ExShopify.Metafield{}]
    }
  end
end
