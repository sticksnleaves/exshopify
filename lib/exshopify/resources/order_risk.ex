defmodule ExShopify.OrderRisk do
  @moduledoc """
  Indicates to a merchant the fraud checks that have been done on an order.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type order_risk_plural :: {:ok, [%ExShopify.OrderRisk{}], %ExShopify.Meta{}}
  @type order_risk_singular :: {:ok, %ExShopify.OrderRisk{}, %ExShopify.Meta{}}

  @plural "risks"
  @singular "risk"

  defstruct [:cause_cancel, :display, :id, :message, :order_id, :recommendation,
             :score, :source]

  @doc """
  Create a new order risk.

  ## Examples

      iex> params = %ExShopify.OrderRisk{
      ...>   message: "This order came from an anonymous proxy",
      ...>   recommendation: "cancel",
      ...>   score: 1.0,
      ...>   source: "External",
      ...>   cause_cancel: true,
      ...>   display: true
      ...> }

      iex> ExShopify.OrderRisk.create(session, 450789469, params)
      {:ok, order_risk, meta}
  """
  @spec create(%ExShopify.Session{}, integer | String.t, map) :: order_risk_singular | ExShopify.Resource.error
  def create(session, order_id, params) do
    request(:post, "/orders/#{order_id}/risks.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Delete an order risk entry.

  ## Examples

      iex> ExShopify.OrderRisk.delete(session, 284138680, 450789469)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t, integer | String.t) :: ExShopify.Resource.meta_only | ExShopify.Resource.error
  def delete(session, id, order_id) do
    request(:delete, "/orders/#{order_id}/risks/#{id}.json", %{}, session)
    |> decode(decoder(nil))
  end

  @doc """
  Get a single order risk by its id.

  ## Examples

      iex> ExShopify.OrderRisk.find(session, 284138680, 450789469)
      {:ok, order_risk, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t) :: order_risk_singular | ExShopify.Resource.error
  def find(session, id, order_id) do
    request(:get, "/orders/#{order_id}/risks/#{id}.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Get a list of all order risks.

  ## Examples

      iex> ExShopify.OrderRisk.list(session, 450789469)
      {:ok, order_risks, meta}
  """
  @spec list(%ExShopify.Session{}, integer | String.t) :: order_risk_plural | ExShopify.Resource.error
  def list(session, order_id) do
    request(:get, "/orders/#{order_id}/risks.json", %{}, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @doc """
  Update an order risk entry.

  ## Examples

      iex> params = %ExShopify.OrderRisk{
      ...>   message: "After further review, this is a legitimate order",
      ...>   recommendation: "accept",
      ...>   source: "External",
      ...>   cause_cancel: false,
      ...>   score: 0.0
      ...> }

      iex> ExShopify.OrderRisk.update(session, 284138680, 450789469, params)
      {:ok, order_risk, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: order_risk_singular | ExShopify.Resource.error
  def update(session, id, order_id, params) do
    request(:put, "/orders/#{order_id}/risks/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
