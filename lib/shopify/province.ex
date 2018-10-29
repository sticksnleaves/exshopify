defmodule Shopify.Province do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/store_properties/province](https://help.shopify.com/en/api/reference/store_properties/province)
  """

  @doc """
  Retrieve a count of all provinces.
  """
  @spec count(binary) :: Shopify.Operation.t()
  def count(country_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/countries/#{country_id}/provinces/count.json"
    }
  end

  @doc """
  Retrieve a province.
  """
  @spec get(binary, binary) :: Shopify.Operation.t()
  def get(country_id, province_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "admin/countries/#{country_id}/provinces/#{province_id}.json"
    }
  end

  @doc """
  Retrieve a list of provinces.
  """
  @spec list(binary, map) :: Shopify.Operation.t()
  def list(country_id, params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "admin/countries/#{country_id}/provinces.json"
    }
  end

  @doc """
  Update a province.
  """
  @spec update(binary, binary, map) :: Shopify.Operation.t()
  def update(country_id, province_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "admin/countries/#{country_id}/provinces/#{province_id}.json"
    }
  end
end
