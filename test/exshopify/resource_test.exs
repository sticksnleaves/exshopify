defmodule ExShopify.Resource.Test do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open
    session = ExShopify.Session.new(%{port: bypass.port})

    {:ok, bypass: bypass, session: session}
  end

  test ":ok response", %{bypass: bypass, session: session} do
    for status_code <- 200..202 do
      Bypass.expect(bypass, fn(conn) ->
        Plug.Conn.put_resp_header(conn, "X-Shopify-Shop-Api-Call-Limit", "1/40")
        |> Plug.Conn.resp(status_code, "{}")
      end)

      {result, body, meta} =
        ExShopify.API.request(:get, "/endpoint", %{}, session)
        |> ExShopify.Resource.serialize_resource(fn (body) ->
          body
        end)

      assert result == :ok
      assert body == "{}"
      assert meta.api_call_limit == "1/40"
    end
  end

  test ":error response", %{bypass: bypass, session: session} do
    for status_code <- [400, 401, 402, 403, 404, 406, 422, 429, 500, 501, 503] do
      Bypass.expect(bypass, fn(conn) ->
        Plug.Conn.resp(conn, status_code, "{}")
      end)

      {result, body} =
        ExShopify.API.request(:get, "/endpoint", %{}, session)
        |> ExShopify.Resource.serialize_resource(fn (body) ->
          body
        end)

      assert result == :error
      assert is_map(body)
    end
  end
end
