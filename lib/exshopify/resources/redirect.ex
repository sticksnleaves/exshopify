defmodule ExShopify.Redirect do
  @moduledoc """
  Request to charge a shop a recurring fee.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type redirect_plural :: {:ok, [%ExShopify.Redirect{}], %ExShopify.Meta{}}
  @type redirect_singular :: {:ok, %ExShopify.Redirect{}, %ExShopify.Meta{}}

  @plural "redirects"
  @singular "redirect"

  defstruct [:id, :path, :target]

  @doc """
  Receive a count of all redirects.

  ## Examples

      iex> ExShopify.Redirect.count(session)
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, map) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, params) do
    request(:get, "/redirects/count.json", params, session)
    |> decode(decoder("count"))
  end

  @spec count(%ExShopify.Session{}) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session) do
    count(session, %{})
  end

  @doc """
  Create a new redirect.

  ## Examples

      iex> params = %{
      ...>   path: "/ipod",
      ...>   target: "/pages/itunes"
      ...> }

      iex> ExShopify.Redirect.create(session, params)
      {:ok, redirect, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: redirect_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/redirects.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Delete a redirect from the database.

  ## Examples

      iex> ExShopify.Redirect.delete(session, 668809255)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.meta_only | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/redirects/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Receive a single redirect.

  ## Examples

      iex> ExShopify.Redirect.find(session, 668809255)
      {:ok, redirect, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: redirect_singular | ExShopify.Resource.error
  def find(session, id, params) do
    request(:get, "/redirects/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: redirect_singular | ExShopify.Resource.error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  Receive a list of all redirects.

  ## Examples

      iex> ExShopify.Redirect.list(session)
      {:ok, redirects, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: redirect_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/redirects.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec list(%ExShopify.Session{}) :: redirect_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Modify an existing redirect.

  ## Examples

      iex> params = %{path: "/tiger"}

      iex> ExShopify.Redirect.update(session, 668809255, params)
      {:ok, redirect, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: redirect_singular | ExShopify.Resource.error
  def update(session, id, params) do
    request(:put, "/redirects/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
