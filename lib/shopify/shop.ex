defmodule Shopify.Shop do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/store_properties/shop](https://help.shopify.com/en/api/reference/store_properties/shop)
  """

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
