defmodule Shopify.InventoryItem do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/inventory/inventoryitem](https://help.shopify.com/en/api/reference/inventory/inventoryitem)
  """

  @doc """
  Retrieve a single inventory item.
  """
  @spec get(binary) :: Shopify.Operation.t()
  def get(inventory_item_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "/inventory_items/#{inventory_item_id}.json"
    }
  end

  @doc """
  Retrieve a list of inventory items.
  """
  @spec list(map) :: Shopify.Operation.t()
  def list(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "/inventory_items.json"
    }
  end


  @doc """
  Update an inventory item.
  """
  @spec update(binary, map) :: Shopify.Operation.t()
  def update(inventory_item_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "/inventory_items/#{inventory_item_id}.json"
    }
  end
end
