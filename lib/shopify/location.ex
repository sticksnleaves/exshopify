defmodule Shopify.Location do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/inventory/location](https://help.shopify.com/en/api/reference/inventory/location)
  """

  @doc """
  Retrieve a count of all locations.
  """
  @spec count :: Shopify.Operation.t()
  def count do
    %Shopify.Operation{
      http_method: :get,
      path: "/locations/count.json"
    }
  end

  @doc """
  Retrieve a single location.
  """
  @spec get(binary) :: Shopify.Operation.t()
  def get(location_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "/locations/#{location_id}.json"
    }
  end

  @doc """
  Retrieve all inventory levels belonging to a location.
  """
  @spec get_inventory_levels(binary) :: Shopify.Operation.t()
  def get_inventory_levels(location_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "/locations/#{location_id}/inventory_levels.json"
    }
  end

  @doc """
  Retrieve a list of locations.
  """
  @spec list :: Shopify.Operation.t()
  def list do
    %Shopify.Operation{
      http_method: :get,
      path: "/locations.json"
    }
  end
end
