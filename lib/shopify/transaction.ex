defmodule Shopify.Transaction do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/orders/transaction](https://help.shopify.com/en/api/reference/orders/transaction)
  """

  @doc """
  Retrieve a count of all transactions.
  """
  @spec count(binary) :: Shopify.Operation.t()
  def count(order_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "/orders/#{order_id}/transactions/count.json"
    }
  end

  @doc """
  Create a transaction.
  """
  @spec create(binary, map) :: Shopify.Operation.t()
  def create(order_id, params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "/orders/#{order_id}/transactions.json"
    }
  end

  @doc """
  Retrieve a single transaction.
  """
  @spec get(binary, binary, map) :: Shopify.Operation.t()
  def get(order_id, transaction_id, params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "/orders/#{order_id}/transactions/#{transaction_id}.json"
    }
  end

  @doc """
  Retrieve a list of transactions.
  """
  @spec list(binary, map) :: Shopify.Operation.t()
  def list(order_id, params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "/orders/#{order_id}/transactions.json"
    }
  end
end
