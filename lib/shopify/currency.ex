defmodule Shopify.Currency do
  @doc """
  Retrieve a list of currencies.
  """
  @spec list :: Shopify.Operation.t()
  def list do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/currencies.json"
    }
  end
end
