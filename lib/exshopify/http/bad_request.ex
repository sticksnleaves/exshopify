defmodule ExShopify.HTTP.BadRequest do
  @moduledoc """
  400 Bad Request
  """

  defstruct [:message, :reason, :status_code]

  @message "The request was not understood by the server, generally due to " <>
           "bad syntax or because the Content-Type header was not correctly " <>
           "set to application/json. This status is also returned when the " <>
           "request provides an invalid code parameter during the OAuth " <>
           "token exchange process."

  @status_code 400

  @spec new(String.t) :: %ExShopify.HTTP.BadRequest{}
  def new(reason) do
    %__MODULE__{
      message: @message,
      reason: reason,
      status_code: @status_code
    }
  end
end
