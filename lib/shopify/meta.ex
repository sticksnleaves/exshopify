defmodule Shopify.Meta do
  @type t :: %__MODULE__{api_call_limit: binary}

  defstruct [:api_call_limit]
end
