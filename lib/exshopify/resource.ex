defmodule ExShopify.Resource do
  @moduledoc """
  Module for building resources.
  """

  @type count :: {:ok, integer, %ExShopify.Meta{}}
  @type delete :: {:ok, %ExShopify.Meta{}}
  @type error :: {:error, struct}
  @type success :: {:ok, struct, %ExShopify.Meta{}}

  @response_errors %{
    400 => ExShopify.HTTP.BadRequest,
    401 => ExShopify.HTTP.Unauthorized,
    402 => ExShopify.HTTP.PaymentRequired,
    403 => ExShopify.HTTP.Forbidden,
    404 => ExShopify.HTTP.NotFound,
    406 => ExShopify.HTTP.NotAcceptable,
    422 => ExShopify.HTTP.UnprocessableEntity,
    429 => ExShopify.HTTP.TooManyRequests,
    500 => ExShopify.HTTP.InternalServerError,
    501 => ExShopify.HTTP.NotImplemented,
    503 => ExShopify.HTTP.ServiceUnavailable
  }

  @doc false
  @spec decode({:ok, %HTTPoison.Response{}}, fun) :: success | ExShopify.Resource.error
  def decode({:ok, response}, decoder) do
    body        = response.body
    status_code = response.status_code

    cond do
      status_code in 200..399 && is_nil(decoder) ->
        {:ok, build_meta(response.headers)}
      status_code in 200..399 ->
        {:ok, decoder.(body), build_meta(response.headers)}
      status_code in 400..599 -> {}
        body = Poison.Parser.parse!(response.body)
        {:error, @response_errors[status_code].new(body["errors"])}
    end
  end

  @doc false
  @spec decode({:error, %HTTPoison.Error{}}, fun) :: error
  def decode(error = {:error, _response}, _decoder) do
    error
  end

  @doc false
  def decoder(object) do
    fn (body) ->
      Poison.Parser.parse!(body)[object]
    end
  end

  @doc false
  def decoder(object, mapping) do
    fn (body) ->
      Poison.decode!(body, as: %{object => mapping})[object]
    end
  end

  @doc false
  def wrap_in_object(map, object) do
    Map.put(%{}, object, map)
  end

  # private

  defp build_meta(headers) do
    meta =
      Enum.reduce(headers, %{}, fn (header, acc) ->
        key   = elem(header, 0)
        value = elem(header, 1)

        case key do
          "X-Shopify-Shop-Api-Call-Limit" ->
            Map.put(acc, :api_call_limit, value)
          _ ->
            acc
        end
      end)

    struct(ExShopify.Meta, meta)
  end
end
