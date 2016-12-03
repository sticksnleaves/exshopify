defmodule ExShopify.Fulfillment do
  @moduledoc """
  A shipment of one or more items in an order.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type fulfillment_plural :: {:ok, [%ExShopify.Fulfillment{}], %ExShopify.Meta{}}
  @type fulfillment_singular :: {:ok, %ExShopify.Fulfillment{}, %ExShopify.Meta{}}

  @plural "fulfillments"
  @singular "fulfillment"

  defstruct [:created_at, :id, :line_items, :order_id, :receipt, :status,
             :tracking_company, :tracking_numbers, :tracking_urls, :updated_at,
             :variant_inventory_management]

  @doc """
  Cancel a fulfillment.

  ## Examples

      iex> ExShopify.Fulfillment.cancel(session, 255858046, 450789469)
      {:ok, fulfillment, meta}
  """
  @spec cancel(%ExShopify.Session{}, integer | String.t, integer | String.t) :: fulfillment_singular | ExShopify.Resource.error
  def cancel(session, id, order_id) do
    request(:post, "/orders/#{order_id}/fulfillments/#{id}/cancel.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Complete a fulfillment.

  ## Examples

      iex> ExShopify.Fulfillment.complete(session, 255858046, 450789469)
      {:ok, fulfillment, meta}
  """
  @spec complete(%ExShopify.Session{}, integer | String.t, integer | String.t) :: fulfillment_singular | ExShopify.Resource.error
  def complete(session, id, order_id) do
    request(:post, "/orders/#{order_id}/fulfillments/#{id}/complete.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Receive a count of all fulfillments.

  ## Examples

      iex> ExShopify.Fulfillment.count(session, 450789469)
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, integer | String.t, map) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, order_id, params) do
    request(:get, "/orders/#{order_id}/fulfillments/count.json", params, session)
    |> decode(decoder("count"))
  end

  @spec count(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, order_id) do
    count(session, order_id, %{})
  end

  @doc """
  Create a new fulfillment.

  ## Examples

      iex> params = %ExShopify.Fulfillment{
      ...>   tracking_number: "123456789010",
      ...>   tracking_company: "fed ex",
      ...>   line_items: [
      ...>     %ExShopify.LineItem{id: "466157049"},
      ...>     %ExShopify.LineItem{id: "518995019"},
      ...>     %ExShopify.LineItem{id: "703073504"}
      ...>   ]
      ...> }

      iex> ExShopify.Fulfillment.create(session, 450789469, params)
      {:ok, fulfillment, meta}
  """
  @spec create(%ExShopify.Session{}, integer | String.t, map) :: fulfillment_singular | ExShopify.Resource.error
  def create(session, order_id, params) do
    request(:post, "/orders/#{order_id}/fulfillments.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Receive a single fulfillment.

  ## Examples

      iex> ExShopify.Fulfillment.find(session, 255858046, 450789469)
      {:ok, fulfillment, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: fulfillment_singular | ExShopify.Resource.error
  def find(session, id, order_id, params) do
    request(:get, "/orders/#{order_id}/fulfillments/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t) :: fulfillment_singular | ExShopify.Resource.error
  def find(session, id, order_id) do
    find(session, id, order_id, %{})
  end

  @doc """
  Receive a list of all fulfillments.

  ## Examples

  ### Get a list of all fulfillments for an order.

      iex> ExShopify.Fulfillment.list(session, 450789469)
      {:ok, fulfillments, meta}

  ### Get all fulfillments after the specified ID

      iex> params = %{
      ...>   since_id: 255858046
      ...> }

      iex> ExShopify.Fulfillment.list(session, 450789469, params)
      {:ok, fulfillments, meta}
  """
  @spec list(%ExShopify.Session{}, integer | String.t, map) :: fulfillment_plural | ExShopify.Resource.error
  def list(session, order_id, params) do
    request(:get, "/orders/#{order_id}/fulfillments.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}, integer | String.t) :: fulfillment_plural | ExShopify.Resource.error
  def list(session, order_id) do
    list(session, order_id, %{})
  end

  @doc """
  Transition a fulfillment from pending to open.

  ## Examples

      iex> ExShopify.Fulfillment.open(session, 255858046, 450789469)
      {:ok, fulfillment, meta}
  """
  @spec open(%ExShopify.Session{}, integer | String.t, integer | String.t) :: fulfillment_singular | ExShopify.Resource.error
  def open(session, id, order_id) do
    request(:post, "/orders/#{order_id}/fulfillments/#{id}/open.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Modify an existing fulfillment.

  ## Examples

      iex> params = %{tracking_number: "987654321"}

      iex> ExShopify.Fulfillment.update(session, 255858046, 450789469, params)
      {:ok, fulfillment, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: fulfillment_singular | ExShopify.Resource.error
  def update(session, id, order_id, params) do
    request(:put, "/orders/#{order_id}/fulfillments/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %ExShopify.OrderFulfillment{
      line_items: [ExShopify.LineItem.response_mapping]
    }
  end
end
