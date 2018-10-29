defmodule Shopify.Policy do
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
