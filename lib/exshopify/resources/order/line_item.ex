defmodule ExShopify.Order.LineItem do
  @moduledoc """
  A list of line item objects, each one containing information about an item in
  the order.
  """

  defstruct [:fulfillable_quantity, :fulfillment_service, :fulfillment_status,
             :gift_card, :grams, :id, :name, :price, :product_id, :properties,
             :quantity, :requires_shipping, :sku, :taxable, :tax_lines,
             :total_discount, :title, :variant_id, :variant_title, :vendor]

  @doc false
  def response_mapping do
    %ExShopify.Order.LineItem{
      properties: [%ExShopify.Property{}],
      tax_lines: [%ExShopify.Order.TaxLine{}]
    }
  end
end
