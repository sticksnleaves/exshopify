defmodule Shopify.ProductImage do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/products/product_image](https://help.shopify.com/en/api/reference/products/product_image)
  """

  @doc """
  Create a product image.
  """
  @spec create(binary, map) :: Shopify.Operation.t()
  def create(product_id, params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "/products/#{product_id}/images.json"
    }
  end

  @doc """
  Delete a product image.
  """
  @spec delete(binary, binary) :: Shopify.Operation.t()
  def delete(product_id, image_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "/products/#{product_id}/images/#{image_id}.json"
    }
  end

  @doc """
  Retrieve a single product image.
  """
  @spec get(binary, binary) :: Shopify.Operation.t()
  def get(product_id, image_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "/products/#{product_id}/images/#{image_id}.json"
    }
  end

  @doc """
  Retrieve a list of product images.
  """
  @spec list(binary, map) :: Shopify.Operation.t()
  def list(product_id, params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "/products/#{product_id}/images.json"
    }
  end

  @doc """
  Update a product image.
  """
  @spec update(binary, binary, map) :: Shopify.Operation.t()
  def update(product_id, image_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "/products/#{product_id}/images/#{image_id}.json"
    }
  end
end
