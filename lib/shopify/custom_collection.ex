defmodule Shopify.CustomCollection do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/products/customcollection](https://help.shopify.com/en/api/reference/products/customcollection)
  """

  @doc """
  Retrieve a count of all custom collections.
  """
  @spec count(map) :: Shopify.Operation.t()
  def count(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/custom_collections/count.json"
    }
  end

  @doc """
  Create a custom collection.
  """
  @spec create(map) :: Shopify.Operation.t()
  def create(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/custom_collections.json"
    }
  end

  @doc """
  Retrieve a single custom collection.
  """
  @spec get(binary) :: Shopify.Operation.t()
  def get(custom_collection_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/custom_collections/#{custom_collection_id}.json"
    }
  end

  @doc """
  Retrieve a list of custom collections.
  """
  @spec list(map) :: Shopify.Operation.t()
  def list(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/custom_collections.json"
    }
  end

  @doc """
  Update a custom collection.
  """
  @spec update(binary, map) :: Shopify.Operation.t()
  def update(custom_collection_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/custom_collections/#{custom_collection_id}.json"
    }
  end
end
