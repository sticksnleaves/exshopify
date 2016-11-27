defmodule ExShopify.Order do
  @moduledoc """
  An order is a customer's completed request to purchase one or more products
  from a shop. An order is created when a customer completes the checkout
  process, during which time s/he provides an email address, billing address and
  payment information.
  """

  use ExShopify.Resource
  import ExShopify.API

  @type order_resource :: {:ok, %ExShopify.Order{}, %ExShopify.Meta{}}
  @type order_count :: {:ok, integer, %ExShopify.Meta{}}

  @plural "orders"
  @singular "order"

  defstruct [:billing_address, :browser_ip, :buyer_accepts_marketing,
             :cancel_reason, :cancelled_at, :cart_token, :client_details,
             :closed_at, :created_at, :currency, :customer, :discount_codes,
             :email, :financial_status, :fulfillments, :fulfillment_status,
             :tags, :id, :landing_site, :line_items, :location_id, :name,
             :note, :note_attributes, :number, :order_number,
             :payment_gateway_names, :processed_at, :processing_method,
             :referring_site, :refunds, :shipping_address, :shipping_lines,
             :source_name, :subtotal_price, :tax_lines, :taxes_included, :token,
             :total_discounts, :total_line_items_price, :total_price,
             :total_tax, :total_weight, :transactions, :updated_at, :user_id,
             :order_status_url]

  @doc """
  Cancel an order.
  """
  @spec cancel(%ExShopify.Session{}, integer | String.t, map) :: order_resource | ExShopify.Resource.error
  def cancel(session \\ nil, id, params \\ %{}) do
    request(:post, "/orders/#{id}/cancel.json", params, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Retrieve a count of all the orders.
  """
  @spec count(%ExShopify.Session{}, map) :: order_count | ExShopify.Resource.error
  def count(session \\ nil, params \\ %{}) do
    request(:get, "/orders/count.json", params, session)
    |> decode(&decode_count/1)
  end

  @doc """
  Close an order.
  """
  @spec close(%ExShopify.Session{}, integer | String.t) :: order_resource | ExShopify.Resource.error
  def close(session \\ nil, id) do
    request(:post, "/orders/#{id}/close.json", %{}, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Create a new order.
  """
  @spec close(%ExShopify.Session{}, map) :: order_resource | ExShopify.Resource.error
  def create(session \\ nil, params) do
    request(:post, "/orders.json", params, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Delete an order.
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: order_resource | ExShopify.Resource.error
  def delete(session \\ nil, id) do
    request(:delete, "/orders/#{id}.json", %{}, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Retrieve a specific order.
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: order_resource | ExShopify.Resource.error
  def find(session \\ nil, id, params \\ %{}) do
    request(:get, "/orders/#{id}.json", params, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Retrieve a list of orders.
  """
  @spec list(%ExShopify.Session{}, map) :: order_resource | ExShopify.Resource.error
  def list(session \\ nil, params \\ %{}) do
    request(:get, "/orders.json", params, session)
    |> decode(&decode_plural/1)
  end

  @doc """
  Re-open a closed order.
  """
  @spec open(%ExShopify.Session{}, map) :: order_resource | ExShopify.Resource.error
  def open(session \\ nil, id) do
    request(:post, "/orders/#{id}/open.json", %{}, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Update an order.
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: order_resource | ExShopify.Resource.error
  def update(session \\ nil, id, params) do
    request(:put, "/orders/#{id}.json", params, session)
    |> decode(&decode_singular/1)
  end

  @doc false
  def response_mapping do
    %ExShopify.Order{
      billing_address: %ExShopify.Address{},
      client_details: %ExShopify.ClientDetails{},
      customer: %ExShopify.Customer{},
      discount_codes: [%ExShopify.DiscountCode{}],
      fulfillments: [ExShopify.Fulfillment.response_mapping],
      line_items: [ExShopify.LineItem.response_mapping],
      refunds: [ExShopify.Refund.response_mapping],
      shipping_address: %ExShopify.Address{},
      shipping_lines: [ExShopify.ShippingLine.response_mapping],
      tax_lines: [%ExShopify.TaxLine{}],
      transactions: [ExShopify.Transaction.response_mapping]
    }
  end
end
