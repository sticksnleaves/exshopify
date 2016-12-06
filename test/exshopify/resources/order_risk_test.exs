defmodule ExShopifyTest.OrderRisk do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open
    session = ExShopify.Session.new(%{port: bypass.port})

    {:ok, bypass: bypass, session: session}
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/orders/1/risks.json"
        assert conn.params == %{"risk" => %{}}

        Plug.Conn.resp(conn, 200, "{\"risk\": {}}")
      end)

      ExShopify.OrderRisk.create(session, 1, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/orders/2/risks/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.OrderRisk.delete(session, 1, 2)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/orders/2/risks/1.json"

        Plug.Conn.resp(conn, 200, "{\"risk\": {}}")
      end)

      ExShopify.OrderRisk.find(session, 1, 2)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/orders/1/risks.json"

        Plug.Conn.resp(conn, 200, "{\"risks\": [{}]}")
      end)

      ExShopify.OrderRisk.list(session, 1)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/orders/2/risks/1.json"
        assert conn.params == %{"risk" => %{}}

        Plug.Conn.resp(conn, 200, "{\"risk\": {}}")
      end)

      ExShopify.OrderRisk.update(session, 1, 2, %{})
    end
  end
end
