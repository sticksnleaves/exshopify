defmodule Shopify.CarrierService do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/shipping_and_fulfillment/carrierservice](https://help.shopify.com/en/api/reference/shipping_and_fulfillment/carrierservice)
  """

  @doc """
  Create a carrier service.
  """
  @spec create(map) :: Shopify.Operation.t()
  def create(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "/carrier_services.json"
    }
  end

  @doc """
  Delete a carrier service.
  """
  @spec delete(binary) :: Shopify.Operation.t()
  def delete(carrier_service_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "/carrier_services/#{carrier_service_id}.json"
    }
  end

  @doc """
  Retrieve a carrier service.
  """
  @spec get(binary) :: Shopify.Operation.t()
  def get(carrier_service_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "/carrier_services/#{carrier_service_id}.json"
    }
  end

  @doc """
  Retrieve a list of carrier services.
  """
  @spec list :: Shopify.Operation.t()
  def list do
    %Shopify.Operation{
      http_method: :get,
      path: "/carrier_services.json"
    }
  end

  @doc """
  Update a carrier service.
  """
  @spec update(binary, map) :: Shopify.Operation.t()
  def update(carrier_service_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "/carrier_services/#{carrier_service_id}.json"
    }
  end
end
