defmodule Shopify.FulfillmentEvent do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/shipping_and_fulfillment/fulfillmentevent](https://help.shopify.com/en/api/reference/shipping_and_fulfillment/fulfillmentevent)
  """

  @doc """
  Create a fulfillment event.
  """
  @spec create(binary, binary, map) :: Shopify.Operation.t()
  def create(order_id, fulfillment_id, params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/orders/#{order_id}/fulfillments/#{fulfillment_id}/events.json"
    }
  end

  @doc """
  Delete a fulfillment event.
  """
  @spec delete(binary, binary, binary) :: Shopify.Operation.t()
  def delete(order_id, fulfillment_id, event_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "admin/orders/#{order_id}/fulfillments/#{fulfillment_id}/events/#{event_id}.json"
    }
  end

  @doc """
  Retrieve a single fulfillment event.
  """
  @spec get(binary, binary, binary) :: Shopify.Operation.t()
  def get(order_id, fulfillment_id, event_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/orders/#{order_id}/fulfillments/#{fulfillment_id}/events/#{event_id}.json"
    }
  end

  @doc """
  Retrieve a list of fulfillment events.
  """
  @spec list(binary, binary) :: Shopify.Operation.t()
  def list(order_id, fulfillment_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/orders/#{order_id}/fulfillments/#{fulfillment_id}/events.json"
    }
  end
end
