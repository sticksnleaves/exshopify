defmodule Shopify.Client.Response do
  @type t :: %__MODULE__{
    body: binary,
    headers: [{binary, binary}],
    status_code: pos_integer
  }

  defstruct body: "",
            headers: nil,
            status_code: nil
end
