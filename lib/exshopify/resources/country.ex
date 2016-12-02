defmodule ExShopify.Country do
  @moduledoc """
  Reader's response to an article in a blog.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type country_plural :: {:ok, [%ExShopify.Country{}], %ExShopify.Meta{}}
  @type country_singular :: {:ok, %ExShopify.Country{}, %ExShopify.Meta{}}

  @plural "countries"
  @singular "country"

  defstruct [:code, :id, :name, :provinces, :tax]

  @doc """
  Get a count of all countries.

  ## Examples

      iex> ExShopify.Country.count(session)
      {:ok, country, meta}
  """
  @spec count(%ExShopify.Session{}) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session) do
    request(:get, "/countries/count.json", %{}, session)
    |> decode(decoder("count"))
  end

  @doc """
  Create a country

  ## Examples

  ### Create a country using Shopify's tax rate for the country

      iex> params = %ExShopify.Country{
      ...>   code: "FR"
      ...> }

  ### Create a country using a custom tax rate

      iex> params = %ExShopify.Country{
      ...>   code: "FR",
      ...>   tax: 0.25
      ...> }

      iex> ExShopify.Country.create(session, params)
      {:ok, country, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: country_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/countries.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Delete a country.

      iex> ExShopify.Country.delete(session, 879921427)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.only_meta | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/countries/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Show country.

  ## Examples

      iex> ExShopify.Country.find(session, 879921427)
      {:ok, country, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: country_singular | ExShopify.Resource.error
  def find(session, id, params) do
    request(:get, "/countries/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: country_singular | ExShopify.Resource.error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  Get a list of all countries

  ## Examples

  ### Get all countries

      iex> ExShopify.Country.list(session)
      {:ok, countries, meta}

  ### Get all countries after the specified ID

      iex> ExShopify.Country.list(session, %{since_id: 359115488})
      {:ok, countries, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: country_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/countries.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: country_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Update a country.

  ## Examples

      iex> ExShopify.Country.update(session, 879921427, %{tax: 0.1})
      {:ok, country, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: country_singular | ExShopify.Resource.error
  def update(session, id, params) do
    request(:put, "/countries/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %ExShopify.Country{
      provinces: [%ExShopify.Province{}]
    }
  end
end
