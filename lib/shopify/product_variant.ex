defmodule Shopify.ProductVariant do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/products/product_variant](https://help.shopify.com/en/api/reference/products/product_variant)
  """

  @doc """
  Retrieve a count of all product variants.
  """
  @spec count(binary) :: Shopify.Operation.t()
  def count(product_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/products/#{product_id}/variants/count.json"
    }
  end

  @doc """
  Create a product variant.
  """
  @spec create(binary, map) :: Shopify.Operation.t()
  def create(product_id, params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/products/#{product_id}/variants.json"
    }
  end

  @doc """
  Delete a product variant.
  """
  @spec delete(binary, binary) :: Shopify.Operation.t()
  def delete(product_id, variant_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "admin/products/#{product_id}/variants/#{variant_id}.json"
    }
  end

  @doc """
  Retrieve a product variant.
  """
  @spec get(binary, binary) :: Shopify.Operation.t()
  def get(product_id, variant_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/products/#{product_id}/variants/#{variant_id}.json"
    }
  end

  @doc """
  Retrieve a list of product variants.
  """
  @spec list(binary, map) :: Shopify.Operation.t()
  def list(product_id, params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/products/#{product_id}/variants.json"
    }
  end

  @doc """
  Update a product variant.
  """
  @spec update(binary, binary, map) :: Shopify.Operation.t()
  def update(product_id, variant_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/products/#{product_id}/variants/#{variant_id}.json"
    }
  end
end
