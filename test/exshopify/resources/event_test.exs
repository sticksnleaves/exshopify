defmodule ExShopifyTest.Event do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open
    session = ExShopify.Session.new(%{port: bypass.port})

    {:ok, bypass: bypass, session: session}
  end

  describe "count" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/events/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\": 1}")
      end)

      ExShopify.Event.count(session)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/events/1.json"

        Plug.Conn.resp(conn, 200, "{\"event\": {}}")
      end)

      ExShopify.Event.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/events.json"

        Plug.Conn.resp(conn, 200, "{\"events\": [{}]}")
      end)

      ExShopify.Event.list(session)
    end
  end

  describe "list_from_order" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/orders/1/events.json"

        Plug.Conn.resp(conn, 200, "{\"events\": [{}]}")
      end)

      ExShopify.Event.list_from_order(session, 1)
    end
  end

  describe "list_from_product" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/products/1/events.json"

        Plug.Conn.resp(conn, 200, "{\"events\": [{}]}")
      end)

      ExShopify.Event.list_from_product(session, 1)
    end
  end
end
