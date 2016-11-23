defmodule ExShopify.HTTP.PaymentRequired do
  @moduledoc """
  402 Payment Required
  """

  defstruct [:message, :reason, :status_code]

  @message "The requested shop is currently frozen."

  @status_code 402

  def new(reason) do
    %__MODULE__{
      message: @message,
      reason: reason,
      status_code: @status_code
    }
  end
end
