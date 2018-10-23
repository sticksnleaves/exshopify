defmodule Shopify.CustomerAddress do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/customers/customer_address](https://help.shopify.com/en/api/reference/customers/customer_address)
  """

  @doc """
  Perform bulk operations on multiple customer addresses.
  """
  @spec bulk(binary, map) :: Shopify.Operation.t()
  def bulk(customer_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/customers/#{customer_id}/set.json"
    }
  end

  @doc """
  Create a new customer address.
  """
  @spec create(binary, map) :: Shopify.Operation.t()
  def create(customer_id, params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/customers/#{customer_id}/addresses.json"
    }
  end

  @doc """
  Delete a customer address.
  """
  @spec delete(binary, binary) :: Shopify.Operation.t()
  def delete(customer_id, address_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "admin/customers/#{customer_id}/addresses/#{address_id}.json"
    }
  end

  @doc """
  Retrieve a single customer address.
  """
  @spec get(binary, binary) :: Shopify.Operation.t()
  def get(customer_id, address_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/customers/#{customer_id}/addresses/#{address_id}.json"
    }
  end

  @doc """
  Retrieve a list of customer addresses.
  """
  @spec list(binary, map) :: Shopify.Operation.t()
  def list(customer_id, params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/customers/#{customer_id}/addresses.json"
    }
  end

  @doc """
  Sets the default address for a customer.
  """
  @spec set_default(binary, binary) :: Shopify.Operation.t()
  def set_default(customer_id, address_id) do
    %Shopify.Operation{
      http_method: :put,
      path: "admin/customers/#{customer_id}/addresses/#{address_id}/default.json"
    }
  end

  @doc """
  Update a customer address.
  """
  @spec update(binary, binary, map) :: Shopify.Operation.t()
  def update(customer_id, address_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/customers/#{customer_id}/addresses/#{address_id}.json"
    }
  end
end
