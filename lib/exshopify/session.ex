defmodule ExShopify.Session do
  defstruct access_token: nil, api_key: nil, domain: "myshopify.com", port: nil,
            protocol: "https", secret: nil, shop_name: nil, shop_url: nil

  def new(config \\ %{}) do
    keys =
      Map.keys(%__MODULE__{})
      |> List.delete(:__struct__)

    map =
      Enum.reduce(keys, %{}, fn(key, acc) ->
        value = config[key] || Application.get_env(:exshopify, key)

        if value do
          Map.put(acc, key, value)
        else
          acc
        end
      end)

    struct(__MODULE__, map)
  end
end
