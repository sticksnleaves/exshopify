defmodule ExShopify.Resource do
  @moduledoc """
  Module for building resources.
  """

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

  @spec serialize_resource({:ok, %HTTPoison.Response{}}, fun) :: success | error
  def serialize_resource({:ok, response}, serializer) do
    body        = response.body
    status_code = response.status_code

    cond do
      status_code in 200..399 ->
        {:ok, serializer.(body), build_meta(response.headers)}
      status_code in 400..599 -> {}
        body = Poison.Parser.parse!(response.body)
        {:error, @response_errors[status_code].new(body["errors"])}
    end
  end

  @spec serialize_resource({:error, %HTTPoison.Error{}}, fun) :: error
  def serialize_resource(error = {:error, _}, _serializer) do
    error
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
