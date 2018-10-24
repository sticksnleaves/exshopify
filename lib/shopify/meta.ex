defmodule Shopify.Meta do
  @type t :: %__MODULE__{
    api_call_limit: {pos_integer, pos_integer}
  }

  defstruct [:api_call_limit]
end
