defmodule ExShopify.HTTP.TooManyRequests do
  @moduledoc """
  429 Too Many Requests
  """

  defstruct [:message, :reason, :status_code]

  @message "The request was not accepted because the application has " <>
           "exceeded the rate limit. See the API Call Limit documentation " <>
           "for a breakdown of Shopify's rate-limiting mechanism."

  @status_code 429

  def new(reason) do
    %__MODULE__{
      message: @message,
      reason: reason,
      status_code: @status_code
    }
  end
end
