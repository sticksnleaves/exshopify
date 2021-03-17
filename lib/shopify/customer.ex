defmodule Shopify.Customer do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/customers/customer](https://help.shopify.com/en/api/reference/customers/customer)
  """

  @doc """
  Retrieve a count of all customers.
  """
  @spec count :: Shopify.Operation.t()
  def count(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "/customers/count.json"
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
      path: "/customers.json"
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
      path: "/customers/#{customer_id}/account_activation_url.json"
    }
  end

  @doc """
  Create a metafield for a customer.

  ## Examples

    iex> data = %{
    ...>   metafield: %{
    ...>     namespace: "inventory",
    ...>     key: "points",
    ...>     value: 25,
    ...>     value_type: "integer"
    ...>   }
    ...> }
    iex> Shopify.Customer.create_metafield("12345", data) |> Shopify.request(session)
    {:ok, %Shopify.Response{}}
  """
  @spec create_metafield(binary, map) :: Shopify.Operation.t()
  def create_metafield(customer_id, params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "/customers/#{customer_id}/metafields.json"
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
      path: "/customers/#{customer_id}.json"
    }
  end

  @doc """
  Delete a single customer metafield

  ## Examples
    iex> Shopify.Customer.delete_metafield("12345", "67890") |> Shopify.request(session)
  """
  @spec delete_metafield(binary, binary) :: Shopify.Operation.t()
  def delete_metafield(customer_id, metafield_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "/customers/#{customer_id}/metafields/#{metafield_id}}.json"
    }
  end

  @doc """
  Retrieve a single customer.
  """
  @spec get(binary) :: Shopify.Operation.t()
  def get(customer_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "/customers/#{customer_id}.json"
    }
  end

  @doc """
  Retrieve a single customer metafield
  """
  @spec get_metafield(binary, binary) :: Shopify.Operation.t()
  def get_metafield(customer_id, metafield_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "/customers/#{customer_id}/metafields/#{metafield_id}}.json"
    }
  end

  @doc """
  Retrieve all metafields belonging to a customer.
  """
  @spec get_metafields(binary) :: Shopify.Operation.t()
  def get_metafields(customer_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "/customers/#{customer_id}/metafields.json"
    }
  end

  @doc """
  Retrieve all orders belonging to a customer.
  """
  @spec get_orders(binary) :: Shopify.Operation.t()
  def get_orders(customer_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "/customers/#{customer_id}.json"
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
      path: "/customers.json"
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
      path: "/customers/search.json"
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
      path: "/customers/#{customer_id}/send_invite.json"
    }
  end

  @doc """
  Update a customer.

  ## Examples
      iex> Shopify.Customer.update("12345", %{customer: %{first_name: "Tester"}) |> Shopify.request(session)
      {:ok, %Shopify.Response{}}

      # Add a metafield to an existing customer
      iex> data = %{
      ...>   customer: %{
      ...>     id: 1092505370733,
      ...>     metafields: [
      ...>       %{
      ...>         key: "my_key",
      ...>         value: "abc",
      ...>         value_type: "string",
      ...>         namespace: "my_group"
      ...>       }
      ...>     ]
      ...>   }
      ...> }
      ...> Shopify.Customer.update("12345", %{customer: %{first_name: "Tester"}) |> Shopify.request(session)
    {:ok, %Shopify.Response{}}
  """
  @spec update(binary, map) :: Shopify.Operation.t()
  def update(customer_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "/customers/#{customer_id}.json"
    }
  end

  @doc """
  Updates a single customer metafield
  """
  @spec update_metafield(binary, binary) :: Shopify.Operation.t()
  def update_metafield(customer_id, metafield_id) do
    %Shopify.Operation{
      http_method: :put,
      path: "/customers/#{customer_id}/metafields/#{metafield_id}}.json"
    }
  end
end
