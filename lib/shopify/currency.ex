defmodule Shopify.Currency do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/store_properties/currency](https://help.shopify.com/en/api/reference/store_properties/currency)
  """

  @doc """
  Retrieve a list of currencies.
  """
  @spec list :: Shopify.Operation.t()
  def list do
    %Shopify.Operation{
      http_method: :get,
      path: "/currencies.json"
    }
  end
end
