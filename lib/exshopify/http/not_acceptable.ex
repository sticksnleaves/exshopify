defmodule ExShopify.HTTP.NotAcceptable do
  @moduledoc """
  406 Not Acceptable
  """

  defstruct [:message, :reason, :status_code]

  @message "The requested resource is only capable of generating content " <>
           "not acceptable according to the Accept headers sent in the request."

  @status_code 406

  def new(reason) do
    %__MODULE__{
      message: @message,
      reason: reason,
      status_code: @status_code
    }
  end
end
