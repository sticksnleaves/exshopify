defmodule ExShopify.Province do
  @moduledoc """
  The sub-regions of a country.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type province_plural :: {:ok, [%ExShopify.Province{}], %ExShopify.Meta{}}
  @type province_singular :: {:ok, %ExShopify.Province{}, %ExShopify.Meta{}}

  @plural "provinces"
  @singular "province"

  defstruct [:code, :country_id, :id, :name, :shipping_zone_id, :tax, :tax_name,
             :tax_type, :tax_percentage]

  @doc """
  Receive a count of all provinces.

  ## Examples

      iex> ExShopify.Province.count(session, 879921427)
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, country_id) do
    request(:get, "/countries/#{country_id}/provinces/count.json", %{}, session)
    |> decode(decoder("count"))
  end

  @doc """
  Receive a single province.

  ## Examples

      iex> ExShopify.Province.find(session, 224293623, 879921427)
      {:ok, province, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: province_singular | ExShopify.Resource.error
  def find(session, id, country_id, params) do
    request(:get, "/countries/#{country_id}/provinces/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t) :: province_singular | ExShopify.Resource.error
  def find(session, id, country_id) do
    find(session, id, country_id, %{})
  end

  @doc """
  Receive a list of all provinces.

  ## Examples

      iex> ExShopify.Province.list(session, 879921427)
      {:ok, provinces, meta}
  """
  @spec list(%ExShopify.Session{}, integer | String.t, map) :: province_plural | ExShopify.Resource.error
  def list(session, country_id, params) do
    request(:get, "/countries/#{country_id}/provinces.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec list(%ExShopify.Session{}, integer | String.t) :: province_plural | ExShopify.Resource.error
  def list(session, country_id) do
    list(session, country_id, %{})
  end

  @doc """
  Modify an exsiting province.

  ## Examples

      iex> params = %{
      ...>   tax: 0.15
      ...> }

      iex> ExShopify.Province.update(session, 224293623, 879921427, params)
      {:ok, province, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: province_singular | ExShopify.Resource.error
  def update(session, id, country_id, params) do
    request(:put, "/countries/#{country_id}/provinces/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
