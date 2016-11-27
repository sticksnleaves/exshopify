defmodule ExShopifyTest.Order do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open
    session = ExShopify.Session.new(%{port: bypass.port})

    {:ok, bypass: bypass, session: session}
  end

  describe "cancel" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/orders/1/cancel.json"

        Plug.Conn.resp(conn, 200, "{\"order\": {}}")
      end)

      ExShopify.Order.cancel(session, 1)
    end
  end

  describe "count" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/orders/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\": 1}")
      end)

      ExShopify.Order.count(session)
    end
  end

  describe "close" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/orders/1/close.json"

        Plug.Conn.resp(conn, 200, "{\"order\": {}}")
      end)

      ExShopify.Order.close(session, 1)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/orders.json"

        Plug.Conn.resp(conn, 200, "{\"order\": {}}")
      end)

      ExShopify.Order.create(session, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/orders/1.json"

        Plug.Conn.resp(conn, 200, "{\"order\": {}}")
      end)

      ExShopify.Order.delete(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/orders/1.json"

        Plug.Conn.resp(conn, 200, "{\"order\": {}}")
      end)

      ExShopify.Order.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/orders.json"

        Plug.Conn.resp(conn, 200, "{\"orders\":[{}]}")
      end)

      ExShopify.Order.list(session)
    end
  end

  describe "open" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/orders/1/open.json"

        Plug.Conn.resp(conn, 200, "{\"orders\":[{}]}")
      end)

      ExShopify.Order.open(session, 1)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "PUT"
        assert conn.request_path == "/admin/orders/1.json"

        Plug.Conn.resp(conn, 200, "{\"order\":{}}")
      end)

      ExShopify.Order.update(session, 1, %{})
    end
  end
end
