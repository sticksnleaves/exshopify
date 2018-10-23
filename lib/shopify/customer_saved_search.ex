defmodule Shopify.CustomerSavedSearch do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/customers/customersavedsearch](https://help.shopify.com/en/api/reference/customers/customersavedsearch)
  """

  @doc """
  Retrieve a count of all customer saved searches.
  """
  @spec count(map) :: Shopify.Operation.t()
  def count(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/customer_saved_searches/count.json"
    }
  end

  @doc """
  Create a customer saved search.
  """
  @spec create(map) :: Shopify.Operation.t()
  def create(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/customer_saved_searches.json"
    }
  end

  @doc """
  Delete a customer saved search.
  """
  @spec delete(binary) :: Shopify.Operation.t()
  def delete(customer_saved_search_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "admin/customer_saved_searches/#{customer_saved_search_id}.json"
    }
  end

  @doc """
  Retrieve a single customer saved search.
  """
  @spec get(binary) :: Shopify.Operation.t()
  def get(customer_saved_search_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/customer_saved_searches/#{customer_saved_search_id}.json"
    }
  end

  @doc """
  Retrieve all customers returned by a customer saved search.
  """
  @spec get_customers(binary, map) :: Shopify.Operation.t()
  def get_customers(customer_saved_search_id, params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/customer_saved_searches/#{customer_saved_search_id}/customers.json"
    }
  end

  @doc """
  Retrieve a list of customers.
  """
  @spec list(map) :: Shopify.Operation.t()
  def list(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/customer_saved_searches.json"
    }
  end

  @doc """
  Update a customer saved search.
  """
  @spec update(binary, map) :: Shopify.Operation.t()
  def update(customer_saved_search_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/customer_saved_searches/#{customer_saved_search_id}.json"
    }
  end
end
