defmodule Shopify.Country do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/store_properties/country](https://help.shopify.com/en/api/reference/store_properties/country)
  """

  @doc """
  Retrieve a count of all customers.
  """
  @spec count :: Shopify.Operation.t()
  def count do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/countries/count.json"
    }
  end

  @doc """
  Create a country.
  """
  @spec create(map) :: Shopify.Operation.t()
  def create(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "admin/countries.json"
    }
  end

  @doc """
  Delete a country.
  """
  @spec delete(binary) :: Shopify.Operation.t()
  def delete(country_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "admin/countries/#{country_id}.json"
    }
  end

  @doc """
  Retrieve a single country.
  """
  @spec get(binary) :: Shopify.Operation.t()
  def get(country_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/countries/#{country_id}.json"
    }
  end

  @doc """
  Retrieve a list of countries.
  """
  @spec list(map) :: Shopify.Operation.t()
  def list(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/countries.json"
    }
  end

  @doc """
  Update a country.
  """
  @spec update(binary, map) :: Shopify.Operation.t()
  def update(country_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/countries/#{country_id}.json"
    }
  end
end
