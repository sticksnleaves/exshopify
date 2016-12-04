defmodule ExShopify.FulfillmentEvent do
  @moduledoc """
  A shipment of one or more items in an order.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type fulfillment_event_plural :: {:ok, [%ExShopify.FulfillmentEvent{}], %ExShopify.Meta{}}
  @type fulfillment_event_singular :: {:ok, %ExShopify.FulfillmentEvent{}, %ExShopify.Meta{}}

  @plural "fulfillment_events"
  @singular "fulfillment_event"

  defstruct [:address1, :city, :country, :created_at, :fulfillment_id,
             :happend_at, :id, :latitude, :longitude, :message, :order_id,
             :province, :shop_id, :status, :updated_at, :zip]

  @doc """
  Create a new fulfillment event.

  ## Examples

      iex> params = %ExShopify.FulfillmentEvent{status: 'in_transit'}

      iex> ExShopify.FulfillmentEvent.create(session, 255858046, 450789469, params)
      {:ok, fulfillment_event, meta}
  """
  @spec create(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: fulfillment_event_singular | ExShopify.Resource.error
  def create(session, fulfillment_id, order_id, params) do
    request(:post, "/orders/#{order_id}/fulfillments/#{fulfillment_id}/events.json", wrap_in_object(params, "event"), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Remove a fulfillment event.

  ## Examples

      iex> ExShopify.FulfillmentEvent.delete(session, 944956391, 255858046, 450789469)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t, integer | String.t, integer | String.t) :: ExShopify.Resource.only_meta | ExShopify.Resource.error
  def delete(session, id, fulfillment_id, order_id) do
    request(:delete, "/orders/#{order_id}/fulfillments/#{fulfillment_id}/events/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Receive a single fulfillment event.

  ## Examples

      iex> ExShopify.FulfillmentEvent.find(session, 944956394, 255858046, 450789469)
      {:ok, fulfillment_event, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t, integer | String.t) :: fulfillment_event_singular | ExShopify.Resource.error
  def find(session, id, fulfillment_id, order_id) do
    request(:get, "/orders/#{order_id}/fulfillments/#{fulfillment_id}/events/#{id}.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Receive a list of all fulfillment events.

  ## Examples

      iex> ExShopify.FulfillmentEvent.list(session, 255858046, 450789469)
      {:ok, fulfillment_events, meta}
  """
  @spec list(%ExShopify.Session{}, integer | String.t, integer | String.t) :: fulfillment_event_plural | ExShopify.Resource.error
  def list(session, fulfillment_id, order_id) do
    request(:get, "/orders/#{order_id}/fulfillments/#{fulfillment_id}/events.json", %{}, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
