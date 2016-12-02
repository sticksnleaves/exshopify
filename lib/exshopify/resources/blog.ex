defmodule ExShopify.Blog do
  @moduledoc """
  Shopify's blogging engine.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type blog_plural :: {:ok, [%ExShopify.Blog{}], %ExShopify.Meta{}}
  @type blog_singular :: {:ok, %ExShopify.Blog{}, %ExShopify.Meta{}}

  @plural "blogs"
  @singular "blog"

  defstruct [:commentable, :created_at, :feedburner, :feedburner_location,
             :handle, :id, :metafields, :tags, :template_suffix, :title,
             :updated_at]

  @doc """
  Get a count of all blogs

  ## Examples

      iex> ExShopify.Blog.count(session)
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session) do
    request(:get, "/blogs/count.json", %{}, session)
    |> decode(decoder("count"))
  end

  @doc """
  Create a new blog.

  ## Examples

  ### Create a new empty blog

      iex> params = %ExShopify.Blog {
      ...>   title: "Apple main blog"
      ...> }

      iex> ExShopify.Blog.create(session, params)
      {:ok, blog, meta}

  ### Create a new empty blog with a metafield

      iex> params = %ExShopify.Blog{
      ...>   title: "Apple main blog",
      ...>   metafields: [
      ...>     %ExShopify.Metafield{
      ...>       key: "new",
      ...>       value: "newvalue",
      ...>       value_type: "string",
      ...>       namespace: "global"
      ...>     }
      ...>   ]
      ...> }

      iex> ExShopify.Blog.create(session, params)
      {:ok, blog, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: blog_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/blogs.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Delete a blog.

  ## Examples

      iex > ExShopify.Blog.delete(session, 241253187)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.only_meta | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/blogs/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Get a single blog by its ID.

  ## Examples

  ### Get a single blog

      iex> ExShopify.Blog.find(session, 241253187)
      {:ok, blog, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: blog_singular | ExShopify.Resource.error
  def find(session, id, params) do
    request(:get, "/blogs/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: blog_singular | ExShopify.Resource.error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  Get a list of all blogs

  ## Examples

  ### Get all blogs for a shop

      iex > ExShopify.Blog.list(session)
      {:ok, blogs, meta}

  ### Get all blogs for a shop after a specified ID

      iex> ExShopify.Blog.list(session, %{since_id: 241253187})
      {:ok, blogs, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: blog_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/blogs.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: blog_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Update a blog.

  ## Examples

      iex> params = %{
      ...>   title: "IPod Updates",
      ...>   handle: "ipod-updates",
      ...>   commentable: "moderate"
      ...> }

      iex> ExShopify.Blog.update(session, 241253187, params)
      {:ok, blog, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: blog_singular | ExShopify.Resource.error
  def update(session, id, params) do
    request(:put, "/blogs/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  def response_mapping do
    %ExShopify.Blog{
      metafields: %ExShopify.Metafield{}
    }
  end
end
