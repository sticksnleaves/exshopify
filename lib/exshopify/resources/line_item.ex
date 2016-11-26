defmodule ExShopify.LineItem do
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
    %ExShopify.LineItem{
      properties: [%ExShopify.Property{}],
      tax_lines: [%ExShopify.TaxLine{}]
    }
  end
end
