defmodule ExShopify.HTTP.NotFound do
  @moduledoc """
  404 Not Found
  """

  defstruct [:message, :reason, :status_code]

  @message "The requested resource was not found but could be available " <>
           "again in the future."

  @status_code 404

  def new(reason) do
    %__MODULE__{
      message: @message,
      reason: reason,
      status_code: @status_code
    }
  end
end
