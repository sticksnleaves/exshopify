defmodule ExShopify.OrderFulfillment do
  @moduledoc """
  A shipment of one or more items in an order.
  """

  defstruct [:created_at, :id, :line_items, :order_id, :receipt, :status,
             :tracking_company, :tracking_number, :updated_at]

  @doc false
  def response_mapping do
    %ExShopify.OrderFulfillment{
      line_items: [ExShopify.LineItem.response_mapping]
    }
  end
end
