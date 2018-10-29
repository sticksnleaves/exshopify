defmodule Shopify.ShippingZone do
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
