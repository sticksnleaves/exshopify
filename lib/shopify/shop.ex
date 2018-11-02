defmodule Shopify.Shop do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/store_properties/shop](https://help.shopify.com/en/api/reference/store_properties/shop)
  """

  @doc """
  Retrieve the shop associated with the provided access token.
  """
  @spec get(map) :: Shopify.Operation.t()
  def get(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/shop.json"
    }
  end
end
