defmodule Shopify.ShippingZone do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/store_properties/shipping_zone](https://help.shopify.com/en/api/reference/store_properties/shipping_zone)
  """

  @doc """
  Retrieve a list of shipping zones.
  """
  @spec list(map) :: Shopify.Operation.t()
  def list(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/shipping_zones.json"
    }
  end
end
