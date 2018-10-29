defmodule Shopify.Policy do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/store_properties/policy](https://help.shopify.com/en/api/reference/store_properties/policy)
  """

  @doc """
  Retrieve a list of policies.
  """
  @spec list :: Shopify.Operation.t()
  def list do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/policies.json"
    }
  end
end
