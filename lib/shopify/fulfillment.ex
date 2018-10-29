defmodule Shopify.Fulfillment do
  @doc """
  Cancel a fulfillment.
  """
  @spec cancel(binary, binary) :: Shopify.Operation.t()
  def cancel(order_id, fulfillment_id) do
    %Shopify.Operation{
      http_method: :post,
      path: "admin/orders/#{order_id}/fulfillments/#{fulfillment_id}/cancel.json"
    }
  end

  @doc """
  Retrieve a count of all fulfillments.
  """
  @spec count(binary, map) :: Shopify.Operation.t()
  def count(order_id, params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/orders/#{order_id}/fulfillments/count.json"
    }
  end

  @doc """
  Create a fulfillment.
  """
  @spec create(binary, map) :: Shopify.Operation.t()
  def create(order_id, params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/orders/#{order_id}/fulfillments.json"
    }
  end

  @doc """
  Retrieve a single fulfillment.
  """
  @spec get(binary, binary) :: Shopify.Operation.t()
  def get(order_id, fulfillment_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/orders/#{order_id}/fulfillments/#{fulfillment_id}.json"
    }
  end

  @doc """
  Retrieve a list of fulfillments.
  """
  @spec list(binary, map) :: Shopify.Operation.t()
  def list(order_id, params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/orders/#{order_id}/fulfillments.json"
    }
  end

  @doc """
  Mark a fulfillment as complete.
  """
  @spec mark_as_complete(binary, binary) :: Shopify.Operation.t()
  def mark_as_complete(order_id, fulfillment_id) do
    %Shopify.Operation{
      http_method: :post,
      path: "admin/orders/#{order_id}/fulfillments/#{fulfillment_id}/complete.json"
    }
  end

  @doc """
  Mark a fulfillment as open.
  """
  @spec mark_as_open(binary, binary) :: Shopify.Operation.t()
  def mark_as_open(order_id, fulfillment_id) do
    %Shopify.Operation{
      http_method: :post,
      path: "admin/orders/#{order_id}/fulfillments/#{fulfillment_id}/open.json"
    }
  end

  @doc """
  Update a fulfillment.
  """
  @spec update(binary, binary, map) :: Shopify.Operation.t()
  def update(order_id, fulfillment_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/orders/#{order_id}/fulfillments/#{fulfillment_id}.json"
    }
  end
end
