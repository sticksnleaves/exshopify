defmodule ExShopify.SmartCollection do
  @moduledoc """
  Reader's response to an article in a blog.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type smart_collection_plural :: {:ok, [%ExShopify.SmartCollection{}], %ExShopify.Meta{}}
  @type smart_collection_singular :: {:ok, %ExShopify.SmartCollection{}, %ExShopify.Meta{}}

  @plural "smart_collections"
  @singular "smart_collection"

  defstruct [:body_html, :disjunctive, :handle, :image, :id, :published,
             :published_at, :published_scope, :rules, :sort_order,
             :template_suffix, :title, :updated_at]

  @doc """
  Receive a count of all smart collections.

  ## Examples

  ### Count all collections

      iex> ExShopify.SmartCollection.count(session)
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, map) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, params) do
    request(:get, "/smart_collections/count.json", params, session)
    |> decode(decoder("count"))
  end

  @spec count(%ExShopify.Session{}) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session) do
    count(session, %{})
  end

  @doc """
  Create a new smart collection.

  ## Examples

  ### Create a new, but unpublished collection

      iex> params = %{
      ...>   title: "Macbooks",
      ...>   published: false
      ...> }

      iex> ExShopify.SmartCollection.create(session, params)
      {:ok, smart_collection, meta}

  ### Create a new collection with a base64 encoded image

      iex> params = %{
      ...>   title: "Macbooks",
      ...>   image: %{ attachment: Base.encode64(File.read("path/to/image.png")) }
      ...> }

      iex> ExShopify.SmartCollection.create(session, params)
      {:ok, smart_collection, meta}

  ### Create a new collection with an image which will be downloaded by Shopify

      iex> params = %{
      ...>   title: "Macbooks",
      ...>   image: %{ src: "http://example.com/elixir_logo.gif" }
      ...> }

      iex> ExShopify.SmartCollection.create(session, params)
      {:ok, smart_collection, meta}

  ### Create a collection of all products starting with the term IPod

      iex> params = %{
      ...>   title: "IPods",
      ...>   rules: [
      ...>     %{
      ...>       column: "title",
      ...>       relation: "starts_with",
      ...>       condition: "iPod"
      ...>     }
      ...>   ]
      ...> }
  """
  @spec create(%ExShopify.Session{}, map) :: smart_collection_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/smart_collections.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Remove smart collection from the database.

  ## Examples

      iex> ExShopify.SmartCollection.delete(session, 841564295)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.only_meta | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/smart_collections/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Receive a single smart collection.

  ## Examples

      iex> ExShopify.SmartCollection.find(session, 482865238)
      {:ok, smart_collection, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: smart_collection_singular | ExShopify.Resource.error
  def find(session, id, params) do
    request(:get, "/smart_collections/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: smart_collection_singular | ExShopify.Resource.error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  Receive a list of all smart collections.

  ## Examples

      iex> ExShopify.SmartCollection.list(session)
      {:ok, smart_collections, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: smart_collection_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/smart_collections.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: smart_collection_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Set the ordering type and/or the manual order of products in a smart
  collection.

  ## Examples

      iex> params = %{
      ...>   sort_order: "alpha-desc"
      ...> }

      iex> ExShopify.SmartCollection.order(session, 482865238, params)
      {:ok, meta}
  """
  @spec order(%ExShopify.Session{}, integer | String.t, map) :: ExShopify.Resource.meta_only | ExShopify.Resource.error
  def order(session, id, params) do
    request(:put, "/smart_collections/#{id}/order.json", params, session)
    |> decode(nil)
  end

  @doc """
  Modify an existing smart collection.

  ## Examples

  ### Update a collection, clearing the collection image

      iex> params = %{
      ...>   image: ""
      ...> }

      iex> ExShopify.SmartCollection.update(session, 482865238, params)
      {:ok, smart_collection, meta}

  ### Change the description of the Smart iPods collection

      iex> params = %{
      ...>   body_html: "<p>5000 songs in your pocket</p>"
      ...> }

      iex> ExShopify.SmartCollection.update(session, 482865238, params)
      {:ok, smart_collection, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: smart_collection_singular | ExShopify.Resource.error
  def update(session, id, params) do
    request(:put, "/smart_collections/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %ExShopify.SmartCollection{
      image: %ExShopify.Image{},
      rules: [%ExShopify.SmartCollectionRule{}]
    }
  end
end
