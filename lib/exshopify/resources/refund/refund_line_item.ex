defmodule ExShopify.Refund.RefundLineItem do
  @moduledoc """
  Details about one returned/refunded item.
  """

  defstruct [:id, :line_item, :line_item_id, :quantity]

  @doc false
  def response_mapping do
    %ExShopify.Refund.RefundLineItem{
      line_item: ExShopify.Order.LineItem.response_mapping
    }
  end
end
