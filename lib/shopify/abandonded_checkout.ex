defmodule Shopify.AbandonedCheckouts do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/orders/abandoned_checkouts](https://help.shopify.com/en/api/reference/orders/abandoned_checkouts)
  """

  @doc """
  Retrieve a count of all abandoned checkouts.
  """
  @spec count(map) :: Shopify.Operation.t()
  def count(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/checkouts/count.json"
    }
  end

  @doc """
  Retrieve a list of abandoned checkouts.
  """
  @spec list(map) :: Shopify.Operation.t()
  def list(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/checkouts.json"
    }
  end
end
