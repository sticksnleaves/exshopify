defmodule ExShopify.ApplicationCredit do
  @moduledoc """
  A credit for a shop.
  """

  use ExShopify.Resource
  import ExShopify.API

  @type application_credit_singular :: {:ok, %ExShopify.ApplicationCredit{}, %ExShopify.Meta{}}
  @type application_credit_plural :: {:ok, [%ExShopify.ApplicationCredit{}], %ExShopify.Meta{}}

  @plural "application_credits"
  @singular "application_credit"

  defstruct [:amount, :description, :id, :test]

  @doc """
  Create a new credit.

  ## Examples

  ### Create a new credit for $5.00 USD

      iex> params = %ExShopify.ApplicationCredit{
      ...>   description: "application credit for refund",
      ...>   amount: 5.0
      ...> }

      iex> ExShopify.ApplicationCredit.create(session, params)
      {:ok, application_credit, meta}

  ### Create a test application credit that will not issue a credit to the merchant

      iex> params = %ExShopify.ApplicationCredit{
      ...>   description: "application credit for refund",
      ...>   amount: 5.0,
      ...>   test: true
      ...> }

      iex> ExShopify.ApplicationCredit.create(session, params)
      {:ok, application_credit, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: application_credit_singular | error
  def create(session, params) do
    request(:post, "/application_credits.json", wrap_singular(params), session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Retrieve a single application credit.

  ## Examples

      iex> ExShopify.ApplicationCharge.find(session, 445365009)
      {:ok, application_charge, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: application_credit_singular | error
  def find(session, id, params) do
    request(:get, "/application_credits/#{id}.json", params, session)
    |> decode(&decode_singular/1)
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: application_credit_singular | error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  All past and present application credits.

  ## Examples

      iex> ExShopify.ApplicationCharge.list(session)
      {:ok, application_charges, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: application_credit_plural | error
  def list(session, params) do
    request(:get, "/application_credits.json", params, session)
    |> decode(&decode_plural/1)
  end

  @spec list(%ExShopify.Session{}) :: application_credit_plural | error
  def list(session) do
    list(session, %{})
  end

  @doc false
  def response_mapping do
    %ExShopify.ApplicationCredit{}
  end
end
