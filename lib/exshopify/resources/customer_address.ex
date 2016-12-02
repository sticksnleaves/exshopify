defmodule ExShopify.CustomerAddress do
  @moduledoc """
  Represents one of the many addresses a customer may have.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type customer_address_plural :: {:ok, [%ExShopify.CustomerAddress{}], %ExShopify.Meta{}}
  @type customer_address_singular :: {:ok, %ExShopify.CustomerAddress{}, %ExShopify.Meta{}}

  @plural "customer_addresses"
  @singular "customer_address"

  defstruct [:address1, :address2, :city, :company, :country, :country_code,
             :country_name, :default, :first_name, :id, :last_name, :name,
             :phone, :province, :province_code, :zip]

  @doc """
  Creates a new address for a customer

  ## Examples

      iex> params = %{
      ...>   address1: "1 Rue des Carrieres",
      ...>   address2: "Suite 1234",
      ...>   city: "Montreal",
      ...>   company: "Fancy Co.",
      ...>   first_name: "Samuel",
      ...>   last_name: "de Champlain",
      ...>   phone: "819-555-5555",
      ...>   province: "Quebec",
      ...>   country: "Canada",
      ...>   zip: "G1R 4P5",
      ...>   name: "Samuel de Champlain",
      ...>   province_code: "QC",
      ...>   country_code: "CA",
      ...>   country_name: "Canada"
      ...> }

      iex> ExShopify.CustomerAddress.create(session, 207119551, params)
      {:ok, customer_address, meta}
  """
  @spec create(%ExShopify.Session{}, integer | String.t, map) :: customer_address_plural | ExShopify.Resource.error
  def create(session, customer_id, params) do
    request(:post, "/customers/#{customer_id}/addresses.json", wrap_in_object(params, "address"), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Removes an address from the customers address list.

  ## Examples

      iex> ExShopify.CustomerAddress.delete(session, 1053317286, 207119551)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t, integer | String.t) :: customer_address_singular | ExShopify.Resource.error
  def delete(session, id, customer_id) do
    request(:delete, "/customers/#{customer_id}/addresses/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Retrieve details for one of a customers addresses

  ## Examples

  ### Get a single customers address

      iex> ExShopify.CustomerAddress.find(session, 207119551, 207119551)
      {:ok, customer_address, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t) :: customer_address_singular | ExShopify.Resource.error
  def find(session, id, customer_id) do
    request(:get, "/customers/#{customer_id}/addresses/#{id}.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Retrieve all addresses for a customer.

  ## Examples

  ### Get all of a customer's addresses

      iex> ExShopify.CustomerAddress.list(session, 207119551)
      {:ok, customer_addresses, meta}

  ### Get a limited number of addresses for a customer

      iex> ExShopify.CustomerAddress.list(session, 207119551, %{limit: 1, page: 1})
      {:ok, customer_addresses, meta}
  """
  @spec list(%ExShopify.Session{}, integer | String.t, map) :: customer_address_plural | ExShopify.Resource.error
  def list(session, customer_id, params) do
    request(:get, "/customers/#{customer_id}/addresses.json", params, session)
    |> decode(decoder("addresses", [response_mapping]))
  end

  @spec list(%ExShopify.Session{}, integer | String.t) :: customer_address_plural | ExShopify.Resource.error
  def list(session, customer_id) do
    list(session, customer_id, %{})
  end

  @doc """
  Assign a new default address to a customer.

  ## Examples

      iex> ExShopify.CustomerAddress.set_default(session, 1053317287, 207119551)
      {:ok, customer_address, meta}
  """
  @spec set_default(%ExShopify.Session{}, integer | String.t, integer | String.t) :: customer_address_singular | ExShopify.Resource.error
  def set_default(session, id, customer_id) do
    request(:put, "/customers/#{customer_id}/addresses/#{id}/default.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Updates the values on an existing customer address.

  ## Examples

      iex> params = %{
      ...>   zip: "90210"
      ...> }

      iex> ExShopify.CustomerAddress.update(session, 207119551, 207119551, params)
      {:ok, customer_address, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: customer_address_singular | ExShopify.Resource.error
  def update(session, id, customer_id, params) do
    request(:put, "/customers/#{customer_id}/addresses/#{id}.json", wrap_in_object(params, "address"), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
