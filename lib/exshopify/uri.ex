#
# Borrowed from Stripity Stripe
# https://github.com/code-corps/stripity-stripe
#
defmodule ExShopify.URI do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      defp build_url(ext \\ "") do
        if ext != "", do: ext = "/" <> ext

        @base <> ext
      end
    end
  end

  @doc """
  Takes a map and turns it into proper query values.
  """
  def encode_query(list) do
    Enum.map_join list, "&", fn x ->
      pair(x)
    end
  end

  defp pair({key, value}) do
    cond do
      Enumerable.impl_for(value) ->
        pair(to_string(key), [], value)
      true ->
        param_name = key |> to_string |> URI.encode_www_form
        param_value = value |> to_string |> URI.encode_www_form

        "#{param_name}=#{param_value}"
    end
  end

  defp pair(root, parents, values) do
    Enum.map_join values, "&", fn {key, value} ->
      cond do
        Enumerable.impl_for(value) ->
          pair(root, parents ++ [key], value)
        true ->
          build_key(root, parents ++ [key]) <> URI.encode_www_form(to_string(value))
      end
    end
  end

  defp build_key(root, parents) do
    path = Enum.map_join parents, "", fn x ->
      param = x |> to_string |> URI.encode_www_form
      "[#{param}]"
    end

    "#{root}#{path}="
  end
end
