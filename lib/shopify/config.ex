defmodule Shopify.Config do
  @type t :: %__MODULE__{
               host: binary,
               http_client: module,
               http_client_opts: any,
               json_codec: module,
               port: pos_integer | nil,
               scheme: binary,
               version: binary
             }

  defstruct host: "myshopify.com",
            http_client: Shopify.Client.Hackney,
            http_client_opts: [],
            json_codec: Jason,
            port: nil,
            scheme: "https",
            version: nil

  @spec new(map) :: t
  def new(overrides \\ %{}) do
    config =
      Application.get_all_env(:exshopify)
      |> Enum.into(%{})
      |> Map.merge(overrides)

    struct(__MODULE__, config)
  end
end
