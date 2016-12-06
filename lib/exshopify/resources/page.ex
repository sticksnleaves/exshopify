defmodule ExShopify.Page do
  @moduledoc """
  Static content customers see often.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type page_plural :: {:ok, [%ExShopify.Page{}], %ExShopify.Meta{}}
  @type page_singular :: {:ok, %ExShopify.Page{}, %ExShopify.Meta{}}

  @plural "pages"
  @singular "page"

  defstruct [:author, :body_html, :created_at, :handle, :id, :metafields,
             :published_at, :shop_id, :template_suffix, :title, :updated_at]

  @doc """
  Receive a count of all pages.

  ## Examples

      iex> ExShopify.Page.count(session)
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, map) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, params) do
    request(:get, "/pages/count.json", params, session)
    |> decode(decoder("count"))
  end

  @spec count(%ExShopify.Session{}) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session) do
    count(session, %{})
  end

  @doc """
  Create a new page.

  ## Examples

  ### Create a new, but unpublished page

      iex> params = %{
      ...>   title: "Warranty information",
      ...>   body_html: "<h1>Warranty</h1>\\n<p><strong>Forget it</strong>, we aint giving you nothing</p>",
      ...>   published: false
      ...> }

      iex> ExShopify.Page.create(session, params)
      {:ok, page, meta}

  ### Create a page with a metafield

      iex> params = %{
      ...>   title: "Warranty information",
      ...>   body_html: "<h1>Warranty</h1>\\n<p><strong>Forget it</strong>, we aint giving you nothing</p>",
      ...>   metafields: [
      ...>     %ExShopify.Metafield{
      ...>       key: "new",
      ...>       value: "newvalue",
      ...>       value_type: "string",
      ...>       namespace: "global"
      ...>     }
      ...>   ]
      ...> }

      iex> ExShopify.Page.create(session, params)
      {:ok, page, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: page_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/pages.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Delete a page.

  ## Examples

      iex> ExShopify.Page.delete(session, 131092082)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.only_meta | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/pages/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Receive a single page.

  ## Examples

      iex> ExShopify.Page.find(session, 131092082)
      {:ok, page, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t) :: page_singular | ExShopify.Resource.error
  def find(session, id) do
    request(:get, "/pages/#{id}.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Receive a list of all pages.

  ## Examples

      iex> ExShopify.Page.list(session)
      {:ok, page, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: page_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/pages.json", params, session)
    |>decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: page_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Update a page.

  ## Examples

  ### Update an existing page body_html

      iex> params = %{
      ...>   body_html: "<p>Okay, maybe we will give you a warranty.</p>"
      ...> }

      iex> ExShopify.Page.update(session, 131092082, params)
      {:ok, page, meta}

  ### Add a metafield to an existing page

      iex> params = %{
      ...>   metafields: [
      ...>     %{
      ...>       key: "new",
      ...>       value: "newvalue",
      ...>       value_type: "string",
      ...>       namespace: "gloabl"
      ...>     }
      ...>   ]
      ...> }

      iex> ExShopify.Page.update(session, 131092082, params)
      {:ok, page, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: page_singular | ExShopify.Resource.error
  def update(session, id, params) do
    request(:put, "/pages/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{
      metafields: [%ExShopify.Metafield{}]
    }
  end
end
