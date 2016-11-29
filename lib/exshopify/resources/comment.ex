defmodule ExShopify.Comment do
  @moduledoc """
  Reader's response to an article in a blog.
  """

  use ExShopify.Resource
  import ExShopify.API

  @type comment_count :: {:ok, integer, %ExShopify.Meta{}}
  @type comment_plural :: {:ok, [%ExShopify.Comment{}], %ExShopify.Meta{}}
  @type comment_singular :: {:ok, %ExShopify.Comment{}, %ExShopify.Meta{}}

  @plural "comments"
  @singular "comment"

  defstruct [:article_id, :author, :blog_id, :body, :body_html, :created_at,
             :email, :id, :ip, :published_at, :status, :updated_at, :user_agent]

  @doc """
  Approve a comment that is currently pending.

  ## Examples

      iex> ExShopify.Comment.approve(session, 653537639)
      {:ok, comment, meta}
  """
  @spec approve(%ExShopify.Session{}, integer | String.t) :: comment_singular | error
  def approve(session, id) do
    request(:post, "/comments/#{id}/approve.json", %{}, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Get a count of all comments for an article.

  ## Examples

  ### Get a count of all the comments for this shop

      iex> ExShopify.Comment.count(session)
      {:ok, count, meta}

  ### Count all comments for a certain article of a blog

      iex> ExShopify.Comment.count(session, %{blog_id: 241253187, article_id: 134645308})
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, map) :: comment_count | error
  def count(session, params) do
    request(:get, "/comments/count.json", params, session)
    |> decode(&decode_count/1)
  end

  @spec count(%ExShopify.Session{}) :: comment_count | error
  def count(session) do
    count(session, %{})
  end

  @doc """
  Create a new comment for an article.

  ## Examples
      iex> params = %ExShopify.Comment{
      ...>   body: "I like comments\\nAnd I like posting them *RESTfully*.",
      ...>   author: "Your name",
      ...>   email: "your@email.com",
      ...>   ip: "107.20.160.121",
      ...>   blog_id: 241253187,
      ...>   article_id: 134645308
      ...> }

      iex> ExShopify.Comment.create(session, params)
      {:ok, comment, meta}
  """
  @spec create(%ExShopify.Comment{}, map) :: comment_singular | error
  def create(session, params) do
    request(:post, "/comments.json", wrap_in_object(params, @singular), session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Get a single comment by its id.

  ## Examples

      iex> ExShopify.Comment.find(session, 118373535)
      {:ok, comment, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t) :: comment_singular | error
  def find(session, id) do
    request(:get, "/comments/#{id}.json", %{}, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Get a list of all comments for an article.

  ## Examples

  ### Get all the comments for this shop

      iex> ExShopify.Comment.list(session)
      {:ok, comments, meta}

  ### Get all the comments for all the articles of a certain blog

      iex> ExShopify.Comment.list(session, %{blog_id: 241253187})
      {:ok, comments, meta}

  ### Get all the comments for a certain article of a blog

      iex> ExShopify.Comment.list(session, %{blog_id: 241253187, article_id: 134645308})
  """
  @spec list(%ExShopify.Session{}, map) :: comment_plural | error
  def list(session, params) do
    request(:get, "/comments.json", params, session)
    |> decode(&decode_plural/1)
  end

  @spec list(%ExShopify.Session{}) :: comment_plural | error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Mark a comment as spam.

  ## Examples

      iex> ExShopify.Comment.mark_as_span(session, 653537639)
      {:ok, comment, meta}
  """
  @spec mark_as_spam(%ExShopify.Session{}, integer | String.t) :: comment_singular | error
  def mark_as_spam(session, id) do
    request(:post, "/comments/#{id}/spam.json", %{}, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Mark a comment as not spam.

  ## Examples

      iex> ExShopify.Comment.mark_as_not_spam(session, 653537639)
      {:ok, comment, meta}
  """
  @spec mark_as_not_spam(%ExShopify.Session{}, integer | String.t) :: comment_singular | error
  def mark_as_not_spam(session, id) do
    request(:post, "/comments/#{id}/not_spam.json", %{}, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Remove a comment.

  ## Examples

      iex> ExShopify.Comment.remove(session, 653537639)
      {:ok, comment, meta}
  """
  @spec remove(%ExShopify.Session{}, integer | String.t) :: comment_singular | error
  def remove(session, id) do
    request(:post, "/comments/#{id}/remove.json", %{}, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Restore a comment

  ## Examples

      iex> ExShopify.Comment.restore(session, 653537639)
      {:ok, comment, meta}
  """
  @spec restore(%ExShopify.Session{}, integer | String.t) :: comment_singular | error
  def restore(session, id) do
    request(:post, "/comments/#{id}/restore.json", %{}, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Update a comment of an article within a blog

  ## Examples

      iex> params = %{
      ...>   body: "You can even update through a web service.",
      ...>   author: "Your new name",
      ...>   email: "your@updated-email.com",
      ...>   published_at: "2016-11-09T18:42:55.227Z"
      ...> }

      iex> ExShopify.Comment.update(session, 118373535, params)
      {:ok, comment, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, %{}) :: comment_singular | error
  def update(session, id, params) do
    request(:put, "/comments/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(&decode_singular/1)
  end

  def response_mapping do
    %__MODULE__{}
  end
end
