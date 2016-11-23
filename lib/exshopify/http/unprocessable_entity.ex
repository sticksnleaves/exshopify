defmodule ExShopify.HTTP.UnprocessableEntity do
  @moduledoc """
  422 Unprocessable Entity
  """

  defstruct [:message, :reason, :status_code]

  @message "The request body was well-formed but contains semantical " <>
           "errors. The response body will provide more details in the " <>
           "errors parameter."

  @status_code 422

  def new(reason) do
    %__MODULE__{
      message: @message,
      reason: reason,
      status_code: @status_code
    }
  end
end
