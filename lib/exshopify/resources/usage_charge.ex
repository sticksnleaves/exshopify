defmodule ExShopify.UsageCharge do
  @moduledoc """
  Charge a variable monthly fee for an app or a service.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type usage_charge_plural :: {:ok, [%ExShopify.UsageCharge{}], %ExShopify.Meta{}}
  @type usage_charge_singular :: {:ok, %ExShopify.UsageCharge{}, %ExShopify.Meta{}}

  @plural "usage_charges"
  @singular "usage_charge"

  defstruct [:created_at, :description, :id, :price,
             :recurring_application_charge_id, :updated_at]

  @doc """
  Create a usage charge.

  ## Examples

      iex> params = %{
      ...>   description: "Super Mega Plan 1000 emails",
      ...>   price: 1.0
      ...> }

      iex> ExShopify.UsageCharge.create(session, 455696195, params)
      {:ok, usage_charge, meta}
  """
  @spec create(%ExShopify.Session{}, integer | String.t, map) :: usage_charge_singular | ExShopify.Resource.error
  def create(session, recurring_application_charge_id, params) do
    request(:post, "/recurring_application_charges/#{recurring_application_charge_id}/usage_charges.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Receive a single usage charge.

  ## Examples

      iex> ExShopify.UsageCharge.find(session, 1034618214, 455696195)
      {:ok, usage_charge, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: usage_charge_singular | ExShopify.Resource.error
  def find(session, id, recurring_application_charge_id, params) do
    request(:get, "/recurring_application_charges/#{recurring_application_charge_id}/usage_charges/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t) :: usage_charge_singular | ExShopify.Resource.error
  def find(session, id, recurring_application_charge_id) do
    find(session, id, recurring_application_charge_id, %{})
  end

  @doc """
  Retrieve all usage charges.

  ## Examples

      iex> ExShopify.UsageCharge.list(session, 455696195)
      {:ok, usage_charges, meta}
  """
  @spec list(%ExShopify.Session{}, integer | String.t, map) :: usage_charge_plural | ExShopify.Resource.error
  def list(session, recurring_application_charge_id, params) do
    request(:get, "/recurring_application_charges/#{recurring_application_charge_id}/usage_charges.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}, integer | String.t) :: usage_charge_plural | ExShopify.Resource.error
  def list(session, recurring_application_charge_id) do
    list(session, recurring_application_charge_id, %{})
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
