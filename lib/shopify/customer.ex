defmodule Shopify.Customer do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/customers/customer](https://help.shopify.com/en/api/reference/customers/customer)
  """

  @doc """
  Retrieve a count of all customers.
  """
  @spec count :: Shopify.Operation.t()
  def count do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/customers/count.json"
    }
  end

  @doc """
  Create a customer.
  """
  @spec create(map) :: Shopify.Operation.t()
  def create(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/customers.json"
    }
  end

  @doc """
  Create an account activation URL for a customer account that is not yet
  enabled.
  """
  @spec create_account_activation_url(binary) :: Shopify.Operation.t()
  def create_account_activation_url(customer_id) do
    %Shopify.Operation{
      http_method: :post,
      path: "admin/customers/#{customer_id}/account_activation_url.json"
    }
  end

  @doc """
  Delete a customer.

  Note that a customer cannot be deleted if they have existing orders.
  """
  @spec delete(binary) :: Shopify.Operation.t()
  def delete(customer_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "admin/customers/#{customer_id}.json"
    }
  end

  @doc """
  Retrieve a single customer.
  """
  @spec get(binary) :: Shopify.Operation.t()
  def get(customer_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/customers/#{customer_id}.json"
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
      path: "admin/customers.json"
    }
  end

  @doc """
  Retrieve all orders belonging to a customers.
  """
  @spec orders(binary) :: Shopify.Operation.t()
  def orders(customer_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/customers/#{customer_id}.json"
    }
  end

  @doc """
  Search for customers that match a given query.
  """
  @spec search(map) :: Shopify.Operation.t()
  def search(params) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/customers/search.json"
    }
  end

  @doc """
  Send an account invite to a customer.
  """
  @spec send_invite(binary, map) :: Shopify.Operation.t()
  def send_invite(customer_id, params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/customers/#{customer_id}/send_invite.json"
    }
  end

  @doc """
  Update a customer.
  """
  @spec update(binary, map) :: Shopify.Operation.t()
  def update(customer_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/customers/#{customer_id}.json"
    }
  end
end
