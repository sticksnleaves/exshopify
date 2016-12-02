defmodule ExShopify.CustomerSavedSearch do
  @moduledoc """
  Group of customers as defined by the shop owner.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type customer_saved_search_plural :: {:ok, [%ExShopify.CustomerSavedSearch{}], %ExShopify.Meta{}}
  @type customer_saved_search_singular :: {:ok, %ExShopify.CustomerSavedSearch{}, %ExShopify.Meta{}}

  @plural "customer_saved_searches"
  @singular "customer_saved_search"

  defstruct [:created_at, :id, :name, :query, :updated_at]

  @doc """
  Get a count of all customer saved searches.

  ## Examples

  ### Get a count all customer saved searches

      iex> ExShopify.CustomerSavedSearch.count(session)
      {:ok, count, meta}

  ### Get a count of all customer saved searches after a specified id

      iex> ExShopify.CustomerSavedSearch.count(session, %{sinced_id: 20610973})
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, map) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, params) do
    request(:get, "/customer_saved_searches/count.json", params, session)
    |> decode(decoder("count"))
  end

  @spec count(%ExShopify.Session{}) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session) do
    count(session, %{})
  end

  @doc """
  Create a new Customer Saved Search.

  ## Examples

  ### Create a new Customer Saved Search

      iex> params = %ExShopify.CustomerSavedSearch{
      ...>   name: "Spent more than $50",
      ...>   query: "total_spent:>50"
      ...> }

      iex> ExShopify.CustomerSavedSearch.create(session, params)
      {:ok, customer_saved_search, meta}

  ### Create a new Customer Saved Search with multiple terms

      iex> params = %ExShopify.CustomerSavedSearch{
      ...>   name: "Spent more than $50 and after 2013",
      ...>   query: "total_spent:>50 order_date:>=2013-01-01"
      ...> }

      iex> ExShopify.CustomerSavedSearch.create(session, params)
      {:ok, customer_saved_search, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: customer_saved_search_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/customer_saved_searches.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Get all customers who match the criteria for the specified customer saved
  search.

  ## Examples

  iex> ExShopify.CustomerSavedSearch.customers(session, 789629109)
  {:ok, customers, meta}
  """
  @spec customers(%ExShopify.Session{}, integer | String.t, map) :: ExShopify.Customer.customer_plural | ExShopify.Resource.error
  def customers(session, customer_saved_search_id, params) do
    request(:get, "/customer_saved_searches/#{customer_saved_search_id}/customers.json", params, session)
    |> decode(decoder("customers", [ExShopify.Customer.response_mapping]))
  end

  @spec customers(%ExShopify.Session{}, integer | String.t) :: ExShopify.Customer.customer_plural | ExShopify.Resource.error
  def customers(session, customer_saved_search_id) do
    customers(session, customer_saved_search_id, %{})
  end

  @doc """
  Delete an existing Customer Saved Search

  ## Examples

      iex> ExShopify.CustomerSavedSearch.delete(session, 789629109)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.only_meta | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/customer_saved_searches/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Get a single customer saved search.

  ## Examples

      iex> ExShopify.CustomerSavedSearch.find(session, 789629109)
      {:ok, customer_saved_search, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: customer_saved_search_singular | ExShopify.Resource.error
  def find(session, id, params) do
    request(:get, "/customer_saved_searches/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: customer_saved_search_singular | ExShopify.Resource.error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  Get a list of all customer saved searches.

  ## Examples

  ### Get all customer saved searches for a shop

      iex> ExShopify.CustomerSavedSearch.list(session)
      {:ok, customer_saved_searches, meta}

  ### Get all customer saved searches for a shop after a specified id

      iex> ExShopify.CustomerSavedSearch.list(session, %{since_id: 20610973})
      {:ok, customer_saved_searches, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: customer_saved_search_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/customer_saved_searches.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: customer_saved_search_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Update an existing Customer Saved Search.

  ## Examples

      iex> params = %{name: "This Name Has Been Changed"}

      iex> ExShopify.CustomerSavedSearch.update(session, 789629109, params)
      {:ok, customer_saved_search, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: customer_saved_search_singular | ExShopify.Resource.error
  def update(session, id, params) do
    request(:put, "/customer_saved_searches/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
