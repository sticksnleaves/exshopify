defmodule ExShopify.HTTP.Unauthorized do
  @moduledoc """
  401 Unauthorized
  """

  defstruct [:message, :reason, :status_code]

  @message "The necessary authentication credentials are not present in the " <>
           "request or are incorrect."

  @status_code 401

  def new(reason) do
    %__MODULE__{
      message: @message,
      reason: reason,
      status_code: @status_code
    }
  end
end
