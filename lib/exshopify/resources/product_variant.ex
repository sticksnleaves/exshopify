defmodule ExShopify.ProductVariant do
  @moduledoc """
  Different version of a product.
  """

  defstruct [:barcode, :compare_at_price, :created_at, :fulfillment_service,
             :grams, :id, :image_id, :inventory_management, :inventory_policy,
             :inventory_quantity, :old_inventory_quantity,
             :inventory_quantity_adjustment, :metafields, :option1, :option2,
             :option3, :position, :price, :product_id, :requires_shipping, :sku,
             :taxable, :title, :updated_at, :weight, :weight_unit]

  @doc false
  def response_mapping do
    %__MODULE__{
      metafields: [%ExShopify.Metafield{}]
    }
  end
end
