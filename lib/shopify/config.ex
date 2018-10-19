defmodule Shopify.Config do
  @type t :: %__MODULE__{
               host: binary,
               http_client: {module, any},
               json_codec: module,
               port: pos_integer | nil,
               scheme: binary
             }

  defstruct host: "myshopify.com",
            http_client: {Shopify.Client.Hackney, []},
            json_codec: Jason,
            port: nil,
            scheme: "https"
end
