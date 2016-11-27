defmodule ExShopify.Article do
  @moduledoc """
  A single entry in a blog.
  """

  use ExShopify.Resource
  import ExShopify.API

  @type author_list :: {:ok, [String.t], %ExShopify.Meta{}}
  @type article_resource :: {:ok, %ExShopify.Article{}, %ExShopify.Meta{}}
  @type article_count :: {:ok, integer, %ExShopify.Meta{}}
  @type tag_list :: {:ok, [String.t], %ExShopify.Meta{}}

  @plural "articles"
  @singular "article"

  defstruct [:author, :blog_id, :body_html, :created_at, :id, :handle, :image,
             :metafields, :published, :published_at, :summary_html, :tags,
             :template_suffix, :title, :updated_at, :user_id]

  @doc """
  Get a list of all the authors of articles.
  """
  @spec authors(%ExShopify.Session{}) :: author_list | ExShopify.Resource.error
  def authors(session \\ nil) do
    request(:get, "/articles/authors.json", %{}, session)
    |> decode(&decode_authors/1)
  end

  @doc """
  Get a count of all articles from a certain blog.
  """
  @spec count(%ExShopify.Session{}, integer | String.t, map) :: article_count | ExShopify.Resource.error
  def count(session \\ nil, blog_id, params \\ %{}) do
    request(:get, "/blogs/#{blog_id}/articles/count.json", params, session)
    |> decode(&decode_count/1)
  end

  @doc """
  Create a new article for a blog.
  """
  @spec create(%ExShopify.Session{}, integer | String.t, map) :: article_resource | ExShopify.Resource.error
  def create(session \\ nil, blog_id, params) do
    request(:post, "/blogs/#{blog_id}/articles.json", params, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Delete an article of a blog.
  """
  @spec delete(%ExShopify.Session{}, integer | String.t, integer | String.t) :: article_resource | ExShopify.Resource.error
  def delete(session \\ nil, id, blog_id) do
    request(:delete, "/blogs/#{blog_id}/articles/#{id}.json", %{}, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Get a single article by its id and the id of the parent blog.
  """
  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: article_resource | ExShopify.Resource.error
  def find(session \\ nil, id, blog_id, params \\ %{}) do
    request(:get, "/blogs/#{blog_id}/articles/#{id}.json", params, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Get a list of all articles from a certain blog.
  """
  @spec list(%ExShopify.Session{}, integer | String.t, map) :: article_resource | ExShopify.Resource.error
  def list(session \\ nil, blog_id, params \\ %{}) do
    request(:get, "/blogs/#{blog_id}/articles.json", params, session)
    |> decode(&decode_plural/1)
  end

  @doc """
  Update an article.
  """
  @spec update(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: article_resource | ExShopify.Resource.error
  def update(session \\ nil, id, blog_id, params \\ %{}) do
    request(:put, "/blogs/#{blog_id}/articles/#{id}.json", params, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Get a list of all the tags of articles.
  """
  @spec tags(%ExShopify.Session{}, map) :: tag_list
  def tags(session \\ nil, params \\ %{}) do
    request(:get, "/articles/tags.json", params, session)
    |> decode(&decode_tags/1)
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
