defmodule Shopify.FulfillmentService do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/shipping_and_fulfillment/fulfillmentservice](https://help.shopify.com/en/api/reference/shipping_and_fulfillment/fulfillmentservice)
  """

  @doc """
  Create a fulfillment service.
  """
  @spec create(map) :: Shopify.Operation.t()
  def create(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/fulfillment_services.json"
    }
  end

  @doc """
  Delete a fulfillment service.
  """
  @spec delete(binary) :: Shopify.Operation.t()
  def delete(fulfillment_service_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "admin/fulfillment_services/#{fulfillment_service_id}.json"
    }
  end

  @doc """
  Retrieve a fulfillment service.
  """
  @spec get(binary) :: Shopify.Operation.t()
  def get(fulfillment_service_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/fulfillment_services/#{fulfillment_service_id}.json"
    }
  end

  @doc """
  Retrieve a list of fulfillment services.
  """
  @spec list(map) :: Shopify.Operation.t()
  def list(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/fulfillment_services.json"
    }
  end

  @doc """
  Update a fulfillment service.
  """
  @spec update(binary, map) :: Shopify.Operation.t()
  def update(fulfillment_service_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/fulfillment_services/#{fulfillment_service_id}.json"
    }
  end
end
