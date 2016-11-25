defmodule ExShopify.API.Test do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open
    session = ExShopify.Session.new(%{port: bypass.port})

    {:ok, bypass: bypass, session: session}
  end

  test "URL construction", %{bypass: bypass, session: session} do
    Bypass.expect(bypass, fn(conn) ->
      assert conn.scheme == String.to_atom(session.protocol)
      assert conn.host == "#{session.shop_name}.#{session.domain}"
      assert conn.port == session.port
      assert conn.request_path == "/admin/endpoint"

      Plug.Conn.resp(conn, 200, "{}")
    end)

    ExShopify.API.request(:get, "/endpoint", %{}, session)
  end

  test ":shop_url override", %{bypass: bypass, session: session} do
    Bypass.expect(bypass, fn(conn) ->
      assert conn.scheme == :http
      assert conn.host == "localhost"
      assert conn.port == bypass.port
      assert conn.request_path == "/notadmin/endpoint"

      Plug.Conn.resp(conn, 200, "{}")
    end)

    ExShopify.API.request(:get, "/endpoint", %{}, Map.merge(session, %{shop_url: "http://localhost:#{bypass.port}/notadmin"}))
  end

  test "query encoding", %{bypass: bypass, session: session} do
    Bypass.expect(bypass, fn(conn) ->
      assert conn.query_string == "a=b"

      Plug.Conn.resp(conn, 200, "{}")
    end)

    ExShopify.API.request(:get, "/endpoint", %{a: "b"}, session)
  end

  test "body parsing", %{bypass: bypass, session: session} do
    params = %{"a" => "b"}

    Bypass.expect(bypass, fn(conn) ->
      conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

      assert conn.params == params

      Plug.Conn.resp(conn, 200, "{}")
    end)

    ExShopify.API.request(:post, "/endpoint", params, session)
  end

  test "content-type header", %{bypass: bypass, session: session} do
    Bypass.expect(bypass, fn(conn) ->
      assert Enum.member?(conn.req_headers, {"content-type", "application/json; charset=utf-8"})

      Plug.Conn.resp(conn, 200, "{}")
    end)

    ExShopify.API.request(:get, "/endpoint", %{}, session)
  end

  test "x-shopify-access-token header", %{bypass: bypass, session: session} do
    access_token = "access_token"

    Bypass.expect(bypass, fn(conn) ->
      assert Enum.member?(conn.req_headers, {"x-shopify-access-token", access_token})

      Plug.Conn.resp(conn, 200, "{}")
    end)

    ExShopify.API.request(:get, "/endpoint", %{}, Map.merge(session, %{access_token: access_token}))
  end
end
