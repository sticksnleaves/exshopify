defmodule ExShopify.PaymentDetail do
  @moduledoc """
  Information about the credit card used for this transaction.
  """

  defstruct [:avs_result_code, :credit_card_bin, :credit_card_company,
             :credit_card_number, :cvv_result_code]
end
