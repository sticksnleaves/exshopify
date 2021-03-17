defmodule Shopify.InventoryLevel do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/inventory/inventorylevel](https://help.shopify.com/en/api/reference/inventory/inventorylevel)
  """

  @doc """
  Adjust the inventory level of an item for a single location.
  """
  @spec adjust(map) :: Shopify.Operation.t()
  def adjust(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "/inventory_levels/adjust.json"
    }
  end

  @doc """
  Connect an inventory item to a location by creating an inventory level.
  """
  @spec connect(map) :: Shopify.Operation.t()
  def connect(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "/inventory_levels/connect.json"
    }
  end

  @doc """
  Delete the inventory level of an item for a single location.
  """
  def delete(params) do
    %Shopify.Operation{
      http_method: :delete,
      params: params,
      path: "/inventory_levels.json"
    }
  end

  @doc """
  Retrieve a list of inventory levels.
  """
  @spec list(map) :: Shopify.Operation.t()
  def list(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "/inventory_levels.json"
    }
  end

  @doc """
  Set the inventory level of an item for a location.
  """
  @spec set(map) :: Shopify.Operation.t()
  def set(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "/inventory_levels/set.json"
    }
  end
end
