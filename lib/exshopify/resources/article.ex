defmodule ExShopify.Article do
  @moduledoc """
  A single entry in a blog.
  """

  use ExShopify.Resource
  import ExShopify.API

  @type author_plural :: {:ok, [String.t], %ExShopify.Meta{}}
  @type article_plural :: {:ok, [%ExShopify.Article{}], %ExShopify.Meta{}}
  @type article_singular :: {:ok, %ExShopify.Article{}, %ExShopify.Meta{}}
  @type article_count :: {:ok, integer, %ExShopify.Meta{}}
  @type tag_plural :: {:ok, [String.t], %ExShopify.Meta{}}

  @plural "articles"
  @singular "article"

  defstruct [:author, :blog_id, :body_html, :created_at, :id, :handle, :image,
             :metafields, :published, :published_at, :summary_html, :tags,
             :template_suffix, :title, :updated_at, :user_id]

  @doc """
  Get a list of all the authors of articles.

  ## Examples

      iex> ExShopify.Article.authors(session)
      {:ok, authors, meta}
  """
  @spec authors(%ExShopify.Session{}) :: author_plural | error
  def authors(session) do
    request(:get, "/articles/authors.json", %{}, session)
    |> decode(&decode_authors/1)
  end

  @doc """
  Get a count of all articles from a certain blog.

  ## Examples

      iex> ExShopify.Article.count(session, 241253187)
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, integer | String.t, map) :: article_count | error
  def count(session, blog_id, params) do
    request(:get, "/blogs/#{blog_id}/articles/count.json", params, session)
    |> decode(&decode_count/1)
  end

  @spec count(%ExShopify.Session{}, integer | String.t) :: article_count | error
  def count(session, blog_id) do
    count(session, blog_id, %{})
  end

  @doc """
  Create a new article for a blog.

  ## Examples

  ### Create a new article with an image which will be downloaded by Shopify

      iex> params = %ExShopify.Article{
      ...>   title: "My new Article title",
      ...>   author: "John Smith",
      ...>   tags: "This Post, Has Been Tagged",
      ...>   body_html: "<h1>I like articles</h1>\\n<p><strong>Yea</strong>, I like posting them through <span class="caps">REST</span>.</p>",
      ...>   published_at: "Thu Mar 24 15:45:47 UTC 2016",
      ...>   image: {
      ...>     src: "http://example.com/elixir_logo.gif"
      ...>   }
      ...> }

      iex> ExShopify.Article.create(session, 241253187, params)
      {:ok, article, meta}

  ### Create a new article with a base64 encoded image

      iex> params = %ExShopify.Article{
      ...>   title: "My new Article title",
      ...>   author: "John Smith",
      ...>   tags: "This Post, Has Been Tagged",
      ...>   body_html: "<h1>I like articles</h1>\\n<p><strong>Yea</strong>, I like posting them through <span class="caps">REST</span>.</p>",
      ...>   published_at: "Thu Mar 24 15:45:47 UTC 2016",
      ...>   image: {
      ...>     attachment: Base.encode64(File.read("path/to/image.png"))
      ...>   }
      ...> }

      iex> ExShopify.Article.create(session, 241253187, params)
      {:ok, article, meta}

  ### Create an article with a metafield

      iex> params = %ExShopify.Article{
      ...>   title: "My new Article title",
      ...>   author: "John Smith",
      ...>   tags: "This Post, Has Been Tagged",
      ...>   body_html: "<h1>I like articles</h1>\\n<p><strong>Yea</strong>, I like posting them through <span class="caps">REST</span>.</p>",
      ...>   published_at: "Thu Mar 24 15:45:47 UTC 2016",
      ...>   metafields: [
      ...>     %ExShopify.Metafield{
      ...>       key: "new",
      ...>       value: "newvalue",
      ...>       value_type: "string",
      ...>       namespace: "global"
      ...>     }
      ...>   ]
      ...> }

      iex> ExShopify.Article.create(session, 241253187, params)
      {:ok, article, meta}
  """
  @spec create(%ExShopify.Session{}, integer | String.t, map) :: article_singular | error
  def create(session, blog_id, params) do
    request(:post, "/blogs/#{blog_id}/articles.json", wrap_in_object(params, @singular), session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Delete an article of a blog.

  ## Examples

      iex> ExShopify.Article.delete(session, 134645308, 241253187)
      {:ok, article, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t, integer | String.t) :: article_singular | error
  def delete(session, id, blog_id) do
    request(:delete, "/blogs/#{blog_id}/articles/#{id}.json", %{}, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Get a single article by its id and the id of the parent blog.

  ## Examples

      iex> ExShopify.Article.find(session, 134645308, 241253187, %{})
      {:ok, article, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: article_singular | error
  def find(session, id, blog_id, params) do
    request(:get, "/blogs/#{blog_id}/articles/#{id}.json", params, session)
    |> decode(&decode_singular/1)
  end

  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t) :: article_singular | error
  def find(session, id, blog_id) do
    find(session, id, blog_id, %{})
  end

  @doc """
  Get a list of all articles from a certain blog.

  ## Examples

  ### Get all the articles

      iex> ExShopify.Article.list(session, 241253187, %{})
      {:ok, articles, meta}

  ### Get all the articles after the specified id

      iex> ExShopify.Article.list(session, 241253187, %{since_id: 134645308})
      {:ok, articles, meta}
  """
  @spec list(%ExShopify.Session{}, integer | String.t, map) :: article_plural | error
  def list(session, blog_id, params) do
    request(:get, "/blogs/#{blog_id}/articles.json", params, session)
    |> decode(&decode_plural/1)
  end

  @spec list(%ExShopify.Session{}, integer | String.t) :: article_plural | error
  def list(session, blog_id) do
    list(session, blog_id, %{})
  end

  @doc """
  Get a list of all the tags of articles.

  ## Examples

  ### Get a list of all tags of articles

      iex> ExShopify.Article.tags(session)
      {:ok, tags, meta}

  ### Get a list of the most popular tags

      iex> ExShopify.Article.tags(session, %{limit: 1, popular: 1})
      {:ok, tags, meta}

  ### Get a list of all tags from a specific blog

      iex> ExShopify.Article.tags(session, 134645308, %{})
      {:ok, tags, meta}

  ### Get a list of the most popular tags

      iex> ExShopify.Article.tags(session, 134645308, %{limit: 1, popular: 1})
      {:ok, tags, meta}
  """
  @spec tags(%ExShopify.Session{}, integer | String.t, map) :: tag_plural
  def tags(session, blog_id, params) do
    endpoint =
      case blog_id do
        nil -> "/articles/tags.json"
        _   -> "/blogs/#{blog_id}/articles/tags.json"

      end

    request(:get, endpoint, params, session)
    |> decode(&decode_tags/1)
  end

  @spec tags(%ExShopify.Session{}, map) :: tag_plural
  def tags(session, params) do
    tags(session, nil, params)
  end

  @spec tags(%ExShopify.Session{}) :: tag_plural
  def tags(session) do
    tags(session, nil, %{})
  end

  @doc """
  Update an article.

  ## Examples

      iex> ExShopify.Article.update(session, 134645308, 241253187, %{published: false})
      {:ok, article, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: article_singular | error
  def update(session, id, blog_id, params) do
    request(:put, "/blogs/#{blog_id}/articles/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(&decode_singular/1)
  end

  @doc false
  def response_mapping do
    %ExShopify.Article{
      metafields: [%ExShopify.Metafield{}]
    }
  end

  # private

  defp decode_authors(body) do
    Poison.Parser.parse!(body)["authors"]
  end

  defp decode_tags(body) do
    Poison.Parser.parse!(body)["tags"]
  end
end
