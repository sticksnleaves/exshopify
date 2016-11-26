defmodule ExShopify.Refund do
  @moduledoc """
  Record of the money returned to the customer, and/or the return of any items
  on an order which may or may not have been restocked.
  """

  defstruct [:created_at, :id, :note, :refund_line_items, :restock,
             :transactions, :user_id]

  @doc false
  def response_mapping do
    %ExShopify.Refund{
      refund_line_items: [ExShopify.RefundLineItem.response_mapping],
      transactions: [ExShopify.Transaction.response_mapping]
    }
  end
end
