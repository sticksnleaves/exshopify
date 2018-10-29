defmodule Shopify.Collect do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/products/collect](https://help.shopify.com/en/api/reference/products/collect)
  """

  @doc """
  Add a product to a collection.
  """
  @spec add_product(map) :: Shopify.Operation.t()
  def add_product(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/collects.json"
    }
  end

  @doc """
  Retrieve a count of all collects.
  """
  @spec count(map) :: Shopify.Operation.t()
  def count(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/collects/count.json"
    }
  end

  @doc """
  Retrieve a single collect.
  """
  @spec get(binary) :: Shopify.Operation.t()
  def get(collect_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/collects/#{collect_id}.json"
    }
  end

  @doc """
  Retrieve a list of collects.
  """
  @spec list(map) :: Shopify.Operation.t()
  def list(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/collects.json"
    }
  end

  @doc """
  Remove a product from a collection.
  """
  @spec remove_product(binary) :: Shopify.Operation.t()
  def remove_product(collect_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "admin/collects/#{collect_id}.json"
    }
  end
end
