defmodule ExShopify.Session do
  @moduledoc """
  Module for managing information pertaining to making API requests

  Possible values:
    * `:access_token`
    * `:api_key`
    * `:domain`
    * `:port`
    * `:protocol`
    * `:secret`
    * `:shop_name`
    * `:shop_url`
  """

  @doc """
  Generate session data.
  """
  @spec create(map) :: map
  def create(config \\ %{}) do
    keys = [:access_token, :api_key, :domain, :port, :protocol, :secret,
            :shop_name, :shop_url]

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
