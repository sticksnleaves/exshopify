defmodule ExShopify.ScriptTag do
  @moduledoc """
   Represents remote javascripts which are loaded into the pages of a shop's
   storefront and in the order status page of checkout.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type script_tag_plural :: {:ok, [%ExShopify.ScriptTag{}], %ExShopify.Meta{}}
  @type script_tag_singular :: {:ok, %ExShopify.ScriptTag{}, %ExShopify.Meta{}}

  @plural "script_tags"
  @singular "script_tag"

  defstruct [:created_at, :display_scope, :event, :id, :src, :updated_at]

  @doc """
  Receive a count of all script tags.

  ## Examples

    iex> ExShopify.ScriptTag.count(session)
    {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, params) do
    request(:get, "/script_tags/count.json", params, session)
    |> decode(decoder("count"))
  end

  @spec count(%ExShopify.Session{}) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session) do
    count(session, %{})
  end

  @doc """
  Create a new script tag.

  ## Examples

      iex> params = %{
      ...>   event: "onload",
      ...>   src: "https://djavaskripped.org/fancy.js"
      ...> }

      iex> ExShopify.ScriptTag.create(session, params)
      {:ok, script_tag, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: script_tag_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/script_tags.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Remove a script tag from the database.

  ## Examples

      iex> ExShopify.ScriptTag.delete(session, 596726825)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.meta_only | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/script_tags/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Receive a single script tag.

  ## Examples

      iex> ExShopify.ScriptTag.find(session, 596726825)
      {:ok, script_tag, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: script_tag_singular | ExShopify.Resource.error
  def find(session, id, params) do
    request(:get, "/script_tags/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: script_tag_singular | ExShopify.Resource.error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  Receive a list of all script tags.

  ## Examples

      iex> ExShopify.ScriptTag.list(session)
      {:ok, script_tags, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: script_tag_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/script_tags.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: script_tag_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Modify an existing script tag.

  ## Examples

      iex> params = %{
      ...>   src: "https://somewhere-else.com/another.js"
      ...> }

      iex> ExShopify.ScriptTag.update(session, 596726825, params)
      {:ok, script_tag, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: script_tag_singular | ExShopify.Resource.error
  def update(session, id, params) do
    request(:put, "/script_tags/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
