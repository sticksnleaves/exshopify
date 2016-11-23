defmodule ExShopify.HTTP.ServiceUnavailable do
  @moduledoc """
  503 Service Unavailable
  """

  defstruct [:message, :reason, :status_code]

  @message "The server is currently unavailable. Check the status page for " <>
           "reported service outages."

  @status_code 503

  def new(reason) do
    %__MODULE__{
      message: @message,
      reason: reason,
      status_code: @status_code
    }
  end
end
