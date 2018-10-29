defmodule Shopify.Refund do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/orders/refund](https://help.shopify.com/en/api/reference/orders/refund)
  """

  @doc """
  Calculate a refund.
  """
  @spec calculate(binary, map) :: Shopify.Operation.t()
  def calculate(order_id, params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/orders/#{order_id}/refunds/calculate.json"
    }
  end

  @doc """
  Create a refund.
  """
  @spec create(binary, map) :: Shopify.Operation.t()
  def create(order_id, params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/orders/#{order_id}/refunds.json"
    }
  end

  @doc """
  Retrieve a single refund.
  """
  @spec get(binary, binary) :: Shopify.Operation.t()
  def get(order_id, refund_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/orders/#{order_id}/refunds/#{refund_id}.json"
    }
  end

  @doc """
  Retrieve a list of refunds.
  """
  @spec list(binary, map) :: Shopify.Operation.t()
  def list(order_id, params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/orders/#{order_id}/refunds.json"
    }
  end
end
