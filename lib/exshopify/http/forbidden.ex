defmodule ExShopify.HTTP.Forbidden do
  @moduledoc """
  403 Forbidden
  """

  defstruct [:message, :reason, :status_code]

  @message "The server is refusing to respond to the request. This is " <>
           "generally because you have not requested the appropriate scope " <>
           "for this action."

  @status_code 403

  def new(reason) do
    %__MODULE__{
      message: @message,
      reason: reason,
      status_code: @status_code
    }
  end
end
