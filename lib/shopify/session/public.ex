defmodule Shopify.Session.Public do
  @type t :: %__MODULE__{access_token: binary, shop_name: binary}

  defstruct access_token: nil, shop_name: nil
end
