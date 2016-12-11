defmodule ExShopify.Theme do
  @moduledoc """
  The look and feel template of a shop.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type theme_plural :: {:ok, [%ExShopify.Theme{}], %ExShopify.Meta{}}
  @type theme_singular :: {:ok, %ExShopify.Theme{}, %ExShopify.Meta{}}

  @plural "themes"
  @singular "theme"

  defstruct [:created_at, :id, :name, :previewable, :processing, :role,
             :updated_at]

  @doc """
  Create a new theme.

  ## Examples

      iex> params = %{
      ...>   name: "Lemongrass",
      ...>   src: "http://themes.shopify.com/theme.zip",
      ...>   role: "main"
      ...> }

      iex> ExShopify.Theme.create(session, params)
      {:ok, theme, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: theme_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/themes.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Delete a theme from the database.

  ## Examples

      iex> ExShopify.Theme.delete(session, 752253240)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.meta_only | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/themes/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Receive a single theme.

  ## Examples

      iex> ExShopify.Theme.find(session, 828155753)
      {:ok, theme, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: theme_singular | ExShopify.Resource.error
  def find(session, id, params) do
    request(:get, "/themes/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: theme_singular | ExShopify.Resource.error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  Receive a list of all themes.

  ## Examples

      iex> ExShopify.Theme.list(session)
      {:ok, themes, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: theme_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/themes.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: theme_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Modify an existing theme.

  ## Examples

      iex> params = %{name: "Experimental"}

      iex> ExShopify.Theme.update(session, 752253240, params)
      {:ok, theme, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: theme_singular | ExShopify.Resource.error
  def update(session, id, params) do
    request(:put, "/themes/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
