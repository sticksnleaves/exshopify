defmodule ExShopify.Transaction do
  @moduledoc """
  Created for every order that results in an exchange of money.
  """

  defstruct [:amount, :authorization, :created_at, :currency, :device_id,
             :error_code, :gateway, :source_name, :payment_details, :id, :kind,
             :order_id, :receipt, :status, :test, :user_id]

  @doc false
  def response_mapping do
    %ExShopify.Transaction{
      payment_details: %ExShopify.Transaction.PaymentDetail{}
    }
  end
end
