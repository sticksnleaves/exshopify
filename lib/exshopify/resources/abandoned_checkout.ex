defmodule ExShopify.AbandonedCheckout do
  @moduledoc """
  A checkout where acustomer has entered their billing & shipping info, but has
  yet to complete the purchase.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type abandoned_checkout_plural :: {:ok, [%ExShopify.AbandonedCheckout{}], %ExShopify.Meta{}}

  @plural "checkouts"
  @singular "checkout"

  defstruct [:abandoned_checkout_url, :billing_address,
             :buyer_accepts_marketing, :cancel_reason, :cart_token, :closed_at,
             :completed_at, :created_at, :currency, :customer, :discount_codes,
             :email, :gateway, :id, :landing_site, :line_items, :note,
             :referring_site, :shipping_address, :shipping_lines, :source_name,
             :subtotal_price, :tax_lines, :taxes_included, :token,
             :total_discounts, :total_line_items_price, :total_price,
             :total_tax, :total_weight, :updated_at]

  @doc """
  Get a count of checkouts.

  ## Examples

      iex> ExShopify.AbandonedCheckout.count(session)
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, map) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, params) do
    request(:get, "/checkouts/count.json", params, session)
    |> decode(decoder("count"))
  end

  @spec count(%ExShopify.Session{}) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session) do
    count(session, %{})
  end

  @doc """
  Retrieve a list of checkouts.

  ## Examples

      iex> ExShopify.AbandonedCheckout.list(session)
      {:ok, checkouts, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: abandoned_checkout_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/checkouts.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: abandoned_checkout_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc false
  def response_mapping do
    %ExShopify.AbandonedCheckout{
      billing_address: %ExShopify.Address{},
      customer: %ExShopify.Customer{},
      discount_codes: [%ExShopify.DiscountCode{}],
      line_items: [%ExShopify.LineItem{}],
      shipping_address: [%ExShopify.Address{}],
      shipping_lines: [ExShopify.ShippingLine.response_mapping],
      tax_lines: [%ExShopify.TaxLine{}]
    }
  end
end
