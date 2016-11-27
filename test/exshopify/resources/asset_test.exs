defmodule ExShopifyTest.Asset do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open
    session = ExShopify.Session.new(%{port: bypass.port})

    {:ok, bypass: bypass, session: session}
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "PUT"
        assert conn.request_path == "/admin/themes/1/assets.json"

        Plug.Conn.resp(conn, 200, "{\"asset\": {}}")
      end)

      ExShopify.Asset.create(session, 1, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/themes/1/assets.json"
        assert conn.query_string == "asset[key]=templates%2F404.liquid"

        Plug.Conn.resp(conn, 200, "{\"asset\": {}}")
      end)

      ExShopify.Asset.delete(session, 1, %{asset: %{key: "templates/404.liquid"}})
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/themes/1/assets.json"
        assert conn.query_string == "asset[key]=templates%2F404.liquid"

        Plug.Conn.resp(conn, 200, "{\"asset\": {}}")
      end)

      ExShopify.Asset.find(session, 1, %{asset: %{key: "templates/404.liquid"}})
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/themes/1/assets.json"

        Plug.Conn.resp(conn, 200, "{\"assets\": [{}]}")
      end)

      ExShopify.Asset.list(session, 1)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "PUT"
        assert conn.request_path == "/admin/themes/1/assets.json"

        Plug.Conn.resp(conn, 200, "{\"asset\": {}}")
      end)

      ExShopify.Asset.update(session, 1, %{})
    end
  end
end
