defmodule ExShopify.RefundLineItem do
  @moduledoc """
  Details about one returned/refunded item.
  """

  defstruct [:id, :line_item, :line_item_id, :quantity]

  @doc false
  def response_mapping do
    %ExShopify.RefundLineItem{
      line_item: ExShopify.LineItem.response_mapping
    }
  end
end
