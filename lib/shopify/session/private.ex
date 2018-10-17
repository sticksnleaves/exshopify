defmodule Shopify.Session.Private do
  @type t :: %__MODULE__{api_key: binary, password: binary, shop_name: binary}

  defstruct api_key: nil, password: nil, shop_name: nil
end
