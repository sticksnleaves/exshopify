defmodule ExShopify.Transaction do
  @moduledoc """
  Created for every order that results in an exchange of money.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type transaction_plural :: {:ok, [%ExShopify.Transaction{}], %ExShopify.Meta{}}
  @type transaction_singular :: {:ok, %ExShopify.Transaction{}, %ExShopify.Meta{}}

  @plural "transactions"
  @singular "transaction"

  defstruct [:amount, :authorization, :created_at, :currency, :device_id,
             :error_code, :gateway, :source_name, :payment_details, :id, :kind,
             :order_id, :receipt, :status, :test, :user_id]

  @doc """
  Receive a count of all transactions.

  ## Examples

      iex> ExShopify.Transaction.count(session, 450789469)
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, order_id) do
    request(:get, "/orders/#{order_id}/transactions/count.json", %{}, session)
    |> decode(decoder("count"))
  end

  @doc """
  Create a new transaction.

  ## Examples

  ### Capture a previously authorized order for the full amount

      iex> params = %{
      ...>   kind: "capture"
      ...> }

      iex> ExShopify.Transaction.create(session, 450789469, params)
      {:ok, transaction, meta}

  ### Capture a specified amount on a previously authorized order

      iex> params = %{
      ...>   amount: "10.00"
      ...>   kind: "capture"
      ...> }

      iex> ExShopify.Transaction.create(session, 450789469, params)
      {:ok, transaction, meta}
  """
  @spec create(%ExShopify.Session{}, integer | String.t, map) :: transaction_singular | ExShopify.Resource.error
  def create(session, order_id, params) do
    request(:post, "/orders/#{order_id}/transactions.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Receive a single transaction.

  ## Examples

      iex> ExShopify.Transaction.find(session, 389404469, 450789469)
      {:ok, transaction, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: transaction_singular | ExShopify.Resource.error
  def find(session, id, order_id, params) do
    request(:get, "/orders/#{order_id}/transactions/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t) :: transaction_singular | ExShopify.Resource.error
  def find(session, id, order_id) do
    find(session, id, order_id, %{})
  end

  @doc """
  Receive a list of all transactions.

  ## Examples

      iex> ExShopify.Transaction.list(session, 450789469)
      {:ok, transactions, meta}
  """
  @spec list(%ExShopify.Session{}, integer | String.t, map) :: transaction_plural | ExShopify.Resource.error
  def list(session, order_id, params) do
    request(:get, "/orders/#{order_id}/transactions.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}, integer | String.t) :: transaction_plural | ExShopify.Resource.error
  def list(session, order_id) do
    list(session, order_id, %{})
  end

  @doc false
  def response_mapping do
    %ExShopify.Transaction{
      payment_details: %ExShopify.PaymentDetails{}
    }
  end
end
