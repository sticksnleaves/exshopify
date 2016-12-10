defmodule ExShopify.RecurringApplicationCharge do
  @moduledoc """
  Request to charge a shop a recurring fee.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type recurring_application_charge_plural :: {:ok, [%ExShopify.RecurringApplicationCharge{}], %ExShopify.Meta{}}
  @type recurring_application_charge_singular :: {:ok, %ExShopify.RecurringApplicationCharge{}, %ExShopify.Meta{}}

  @plural "recurring_application_charges"
  @singular "recurring_application_charge"

  defstruct [:activated_on, :billing_on, :cancelled_on, :capped_amount,
             :confirmation_url, :created_at, :id, :name, :price, :return_url,
             :status, :terms, :test, :trial_days, :trial_ends_on, :updated_at]

  @doc """
  Activate a recurring application charge.

  ## Examples

      iex> ExShopify.RecurringApplicationCharge.activate(session, 455696195)
      {:ok, recurring_application_charge, meta}
  """
  @spec activate(%ExShopify.Session{}, integer | String.t) :: recurring_application_charge_singular | ExShopify.Resource.error
  def activate(session, id) do
    request(:post, "/recurring_application_charges/#{id}/activate.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Create a recurring application charge.

  ## Examples

  ### Create a new charge called 'Super Duper Plan' for $10.00 USD per month

      iex> params = %{
      ...>   name: "Super Duper Plan",
      ...>   price: 10.0,
      ...>   return_url: "http://super-duper.shopifyapps.com"
      ...> }

      iex> ExShopify.RecurringApplicationCharge.create(session, params)
      {:ok, recurring_application_charge, meta}

  ### Create a recurring test charge that will not cause a credit card to be charged

      iex> params = %{
      ...>   name: "Super Duper Plan",
      ...>   price: 10.0,
      ...>   return_url: "http://super-duper.shopifyapps.com",
      ...>   test: true
      ...> }

      iex> ExShopify.RecurringApplicationCharge.create(session, params)
      {:ok, recurring_application_charge, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: recurring_application_charge_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/recurring_application_charges.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Customize a recurring application charge.

  ## Examples

      iex> params = %{
      ...>   capped_amount: 200
      ...> }

      iex> ExShopify.RecurringApplicationCharge.customize(session, 455696195, params)
      {:ok, recurring_application_charge, meta}
  """
  @spec customize(%ExShopify.Session{}, integer | String.t, map) :: recurring_application_charge_singular | ExShopify.Resource.error
  def customize(session, id, params) do
    request(:put, "/recurring_application_charges/#{id}/customize.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Cancel a recurring application charge.

  ## Examples

      iex> ExShopify.RecurringApplicationCharge.delete(session, 455696195)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.meta_only | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/recurring_application_charges/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Receive a single recurring application charge.

  ## Examples

      iex> ExShopify.RecurringApplicationCharge.find(session, 455696195)
      {:ok, recurring_application_charge, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: recurring_application_charge_singular | ExShopify.Resource.error
  def find(session, id, params) do
    request(:get, "/recurring_application_charges/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: recurring_application_charge_singular | ExShopify.Resource.error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  Receive all recurring application charges.

  ## Examples

      iex> ExShopify.RecurringApplicationCharge.list(session)
      {:ok, recurring_application_charge, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: recurring_application_charge_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/recurring_application_charges.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: recurring_application_charge_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
