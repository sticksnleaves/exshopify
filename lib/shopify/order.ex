defmodule Shopify.Order do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/orders/order](https://help.shopify.com/en/api/reference/orders/order)
  """

  @doc """
  Cancel an order.
  """
  @spec cancel(binary, map) :: Shopify.Operation.t()
  def cancel(order_id, params \\ %{}) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/orders/#{order_id}/cancel.json"
    }
  end

  @doc """
  Close an order.
  """
  @spec close(binary) :: Shopify.Operation.t()
  def close(order_id) do
    %Shopify.Operation{
      http_method: :post,
      path: "admin/orders/#{order_id}/close.json"
    }
  end

  @doc """
  Retrieve a count of all orders.
  """
  @spec count(map) :: Shopify.Operation.t()
  def count(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/orders/count.json"
    }
  end

  @doc """
  Create an order.
  """
  @spec create(map) :: Shopify.Operation.t()
  def create(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/orders.json"
    }
  end

  @doc """
  Delete an order.
  """
  @spec delete(binary) :: Shopify.Operation.t()
  def delete(order_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "admin/orders/#{order_id}.json"
    }
  end

  @doc """
  Retrieve a single order.
  """
  @spec get(binary) :: Shopify.Operation.t()
  def get(order_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/orders/#{order_id}.json"
    }
  end

  @doc """
  Retrieve a list of orders.
  """
  @spec list(map) :: Shopify.Operation.t()
  def list(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/orders.json"
    }
  end

  @doc """
  Reopen an order.
  """
  @spec open(binary) :: Shopify.Operation.t()
  def open(order_id) do
    %Shopify.Operation{
      http_method: :post,
      path: "admin/orders/#{order_id}.json"
    }
  end

  @doc """
  Update an order.
  """
  @spec update(binary, map) :: Shopify.Operation.t()
  def update(order_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/orders/#{order_id}.json"
    }
  end
end
