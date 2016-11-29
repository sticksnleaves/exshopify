defmodule ExShopify.ApplicationCharge do
  @moduledoc """
  A one-time charge to a shop.
  """

  use ExShopify.Resource
  import ExShopify.API

  @type application_charge_singular :: {:ok, %ExShopify.ApplicationCharge{}, %ExShopify.Meta{}}
  @type application_charge_plural :: {:ok, [%ExShopify.ApplicationCharge{}], %ExShopify.Meta{}}

  @plural "application_charges"
  @singular "application_charge"

  defstruct [:confirmation_url, :created_at, :id, :name, :price, :return_url,
             :status, :test, :updated_at]

  @doc """
  Activate a previously accepted one-time application charge.

  ## Examples

      iex> ExShopify.ApplicationChrage.activate(session, 1240375)
      {:ok, application_charge, meta}
  """
  @spec activate(%ExShopify.Session{}, integer | String.t) :: application_charge_singular | error
  def activate(session, id) do
    request(:post, "/application_charges/#{id}/activate.json", %{}, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Create a new one-time application charge.

  ## Examples

      iex> params = %ExShopify.ApplicationCharge{
      ...>   name: "Super Duper Expensive action",
      ...>   price: 100.0,
      ...>   return_url: "http://super-duper.shopifyapps.com"
      ...> }

      iex> ExShopify.ApplicationCharge.create(session, params)
      {:ok, application_charge, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: application_charge_singular | error
  def create(session, params) do
    request(:post, "/application_charges.json", wrap_in_object(params, @singular), session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Retrieve one-time application charge.

  ## Examples

      iex> ExShopify.ApplicationCharge.find(session, 675931192)
      {:ok, application_charge, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: application_charge_singular | error
  def find(session, id, params) do
    request(:get, "/application_charges/#{id}.json", params, session)
    |> decode(&decode_singular/1)
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: application_charge_singular | error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  All charges that have been requested are retrieved by this request.

  ## Examples

      iex> ExShopify.ApplicationCharge.list
      {:ok, application_charges, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: application_charge_plural | error
  def list(session, params) do
    request(:get, "/application_charges.json", params, session)
    |> decode(&decode_plural/1)
  end

  @spec list(%ExShopify.Session{}) :: application_charge_plural | error
  def list(session) do
    list(session, %{})
  end

  @doc false
  def response_mapping do
    %ExShopify.ApplicationCharge{}
  end
end
