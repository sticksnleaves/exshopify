defmodule ExShopify.ShippingZone do
  @moduledoc """
  Regions that are shipped to.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type shipping_zone_plural :: {:ok, [%ExShopify.ShippingZone{}], %ExShopify.Meta{}}

  @plural "shipping_zones"

  defstruct [:carrier_shipping_rate_providers, :countries, :id, :name,
             :price_based_shipping_rates, :provinces,
             :weight_based_shipping_rates]

  @doc """
  Receive a list of all shipping zones.

  ## Examples

      iex> ExShopify.ShippingZone.list(session)
      {:ok, shipping_zones, meta}
  """
  @spec list(%ExShopify.ShippingZone{}, map) :: shipping_zone_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/shipping_zones.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.ShippingZone{}) :: shipping_zone_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc false
  def response_mapping do
    %__MODULE__{
      countries: [%ExShopify.Country{}],
      provinces: [%ExShopify.Province{}]
    }
  end
end
