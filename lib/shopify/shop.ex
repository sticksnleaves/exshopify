defmodule Shopify.Shop do
  @doc """
  Retrieve the configuration for a shop.
  """
  @spec get_config(map) :: Shopify.Operation.t()
  def get_config(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/shop.json"
    }
  end
end
