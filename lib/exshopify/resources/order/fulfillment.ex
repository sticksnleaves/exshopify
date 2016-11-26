defmodule ExShopify.Order.Fulfillment do
  defstruct [:created_at, :id, :line_items, :order_id, :receipt, :status,
             :tracking_company, :tracking_number, :updated_at]

  @doc false
  def response_mapping do
    %ExShopify.Order.Fulfillment{
      line_items: [ExShopify.Order.LineItem.response_mapping]
    }
  end
end
