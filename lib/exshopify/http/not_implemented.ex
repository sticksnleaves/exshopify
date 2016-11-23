defmodule ExShopify.HTTP.NotImplemented do
  @moduledoc """
  501 Not Implemented
  """

  defstruct [:message, :reason, :status_code]

  @message "The requested endpoint is not available on that particular " <>
           "shop, e.g. requesting access to a Plus-specific API on a " <>
           "non-Plus shop. This response may also indicate that this " <>
           "endpoint is reserved for future use."

  @status_code 501

  def new(reason) do
    %__MODULE__{
      message: @message,
      reason: reason,
      status_code: @status_code
    }
  end
end
