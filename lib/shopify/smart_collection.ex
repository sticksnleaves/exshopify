defmodule Shopify.SmartCollection do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/products/smartcollection](https://help.shopify.com/en/api/reference/products/smartcollection)
  """

  @doc """
  Retrieve a count of all smart collections.
  """
  @spec count(map) :: Shopify.Operation.t()
  def count(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/smart_collections/count.json"
    }
  end

  @doc """
  Create a smart collection.
  """
  @spec create(map) :: Shopify.Operation.t()
  def create(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admins/smart_collections.json"
    }
  end

  @doc """
  Delete a smart collection.
  """
  @spec delete(binary) :: Shopify.Operation.t()
  def delete(smart_collection_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "admins/smart_collections/#{smart_collection_id}.json"
    }
  end

  @doc """
  Retrieve a single smart collection.
  """
  @spec get(binary, map) :: Shopify.Operation.t()
  def get(smart_collection_id, params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/smart_collections/#{smart_collection_id}.json"
    }
  end

  @doc """
  Retrieve a list of all smart collections.
  """
  @spec list(map) :: Shopify.Operation.t()
  def list(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/smart_collections.json"
    }
  end

  @doc """
  Update a smart collection.
  """
  @spec update(binary, map) :: Shopify.Operation.t()
  def update(smart_collection_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/smart_collections/#{smart_collection_id}.json"
    }
  end

  @doc """
  Update the ordering type of products in a smart collection.
  """
  @spec update_order(binary, map) :: Shopify.Operation.t()
  def update_order(smart_collection_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/smart_collections/#{smart_collection_id}/order.json"
    }
  end
end
