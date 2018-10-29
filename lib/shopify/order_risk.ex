defmodule Shopify.OrderRisk do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/orders/order_risk](https://help.shopify.com/en/api/reference/orders/order_risk)
  """

  @doc """
  Create an order risk.
  """
  @spec create(binary, map) :: Shopify.Operation.t()
  def create(order_id, params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/orders/#{order_id}/risks.json"
    }
  end

  @doc """
  Delete an order risk.
  """
  @spec delete(binary, binary) :: Shopify.Operation.t()
  def delete(order_id, risk_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "admin/orders/#{order_id}/risks/#{risk_id}.json"
    }
  end

  @doc """
  Retrieve a single order risk.
  """
  @spec get(binary, binary) :: Shopify.Operation.t()
  def get(order_id, risk_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/orders/#{order_id}/risks/#{risk_id}.json"
    }
  end

  @doc """
  Retrieve a list of order risks.
  """
  @spec list(binary) :: Shopify.Operation.t()
  def list(order_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/orders/#{order_id}/risks.json"
    }
  end

  @doc """
  Update an order risk.
  """
  @spec update(binary, binary, map) :: Shopify.Operation.t()
  def update(order_id, risk_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/orders/#{order_id}/risks/#{risk_id}.json"
    }
  end
end
