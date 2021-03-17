defmodule Shopify.Product do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/products/product](https://help.shopify.com/en/api/reference/products/product)
  """

  @doc """
  Retrieve a count of all products.
  """
  @spec count(map) :: Shopify.Operation.t()
  def count(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "/products/count.json"
    }
  end

  @doc """
  Create a product.
  """
  @spec create(map) :: Shopify.Operation.t()
  def create(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "/products.json"
    }
  end

  @doc """
  Delete a product.
  """
  @spec delete(binary) :: Shopify.Operation.t()
  def delete(product_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "/products/#{product_id}.json"
    }
  end

  @doc """
  Retrieve a single product.
  """
  @spec get(binary, map) :: Shopify.Operation.t()
  def get(product_id, params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "/products/#{product_id}.json"
    }
  end

  @doc """
  Retrieve a list of products.
  """
  @spec list(map) :: Shopify.Operation.t()
  def list(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "/products.json"
    }
  end

  @doc """
  Update a product.
  """
  @spec update(binary, map) :: Shopify.Operation.t()
  def update(product_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "/products/#{product_id}.json"
    }
  end
end
