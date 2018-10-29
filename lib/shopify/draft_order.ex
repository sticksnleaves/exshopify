defmodule Shopify.DraftOrder do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/orders/draftorder](https://help.shopify.com/en/api/reference/orders/draftorder)
  """

  @doc """
  Complete a draft order.
  """
  @spec complete(binary, map) :: Shopify.Operation.t()
  def complete(draft_order_id, params \\ %{}) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/draft_orders/#{draft_order_id}/complete.json"
    }
  end

  @doc """
  Retrieve a count of all draft orders.
  """
  @spec count(map) :: Shopify.Operation.t()
  def count(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/draft_orders/count.json"
    }
  end

  @doc """
  Create a draft order.
  """
  @spec create(map) :: Shopify.Operation.t()
  def create(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/draft_orders.json"
    }
  end

  @doc """
  Delete a draft order.
  """
  @spec delete(binary) :: Shopify.Operation.t()
  def delete(draft_order_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "admin/draft_orders/#{draft_order_id}.json"
    }
  end

  @doc """
  Retrieve a single draft order.
  """
  @spec get(binary) :: Shopify.Operation.t()
  def get(draft_order_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/draft_orders/#{draft_order_id}.json"
    }
  end

  @doc """
  Retrieve a list of draft orders.
  """
  @spec list(map) :: Shopify.Operation.t()
  def list(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/draft_orders.json"
    }
  end

  @doc """
  Send an invoice for a draft order.
  """
  @spec send_invoice(binary, map) :: Shopify.Operation.t()
  def send_invoice(draft_order_id, params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/draft_orders/#{draft_order_id}/send_invoice.json"
    }
  end

  @doc """
  Update a draft order.
  """
  @spec update(binary, map) :: Shopify.Operation.t()
  def update(draft_order_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/draft_orders/#{draft_order_id}.json"
    }
  end
end
