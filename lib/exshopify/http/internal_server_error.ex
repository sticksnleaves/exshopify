defmodule ExShopify.HTTP.InternalServerError do
  @moduledoc """
  500 Internal Server Error
  """

  defstruct [:message, :reason, :status_code]

  @message "An internal error occurred in Shopify. Please post to the API & " <>
           "Technology forum so that Shopify staff can investigate."

  @status_code 500

  def new(reason) do
    %__MODULE__{
      message: @message,
      reason: reason,
      status_code: @status_code
    }
  end
end
