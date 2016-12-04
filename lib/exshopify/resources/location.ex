defmodule ExShopify.Location do
  @moduledoc """
  A geographical location where your stores, headquarters, and/or pop-up stores
  exist.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type location_plural :: {:ok, [%ExShopify.Location{}], %ExShopify.Meta{}}
  @type location_singular :: {:ok, %ExShopify.Location{}, %ExShopify.Meta{}}

  @plural "locations"
  @singular "location"

  defstruct [:address1, :address2, :city, :country, :created_at, :id, :name,
             :phone, :province, :updated_at, :zip]

  @doc """
  Receive a single location.

  ## Examples

      iex> ExShopify.Location.find(session, 487838322)
      {:ok, locations, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t) :: location_singular | ExShopify.Resource.error
  def find(session, id) do
    request(:get, "/locations/#{id}.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Receive a list of all locations.

  ## Examples

      iex> ExShopify.Location.list(session)
      {:ok, locations, meta}
  """
  @spec list(%ExShopify.Session{}) :: location_plural | ExShopify.Resource.error
  def list(session) do
    request(:get, "/locations.json", %{}, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
