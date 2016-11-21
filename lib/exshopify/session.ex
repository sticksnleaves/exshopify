defmodule ExShopify.Session do
  def create(config \\ %{}) do
    keys = [:access_token, :api_key, :shared_secret, :shop_name, :shop_url]

    Enum.reduce(keys, %{}, fn(key, acc) ->
      value = config[key] || Application.get_env(:exshopify, key)

      if value do
        Map.put(acc, key, value)
      else
        acc
      end
    end)
  end
end
