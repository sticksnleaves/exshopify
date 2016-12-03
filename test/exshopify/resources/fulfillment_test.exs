defmodule ExShopifyTest.Fulfillment do
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
        assert conn.request_path == "/admin/orders/2/fulfillments/1/cancel.json"

        Plug.Conn.resp(conn, 200, "{\"fulfillment\": {}}")
      end)

      ExShopify.Fulfillment.cancel(session, 1, 2)
    end
  end

  describe "complete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/orders/2/fulfillments/1/complete.json"

        Plug.Conn.resp(conn, 200, "{\"fulfillment\": {}}")
      end)

      ExShopify.Fulfillment.complete(session, 1, 2)
    end
  end

  describe "count" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/orders/1/fulfillments/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\": 1}")
      end)

      ExShopify.Fulfillment.count(session, 1)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/orders/1/fulfillments.json"
        assert conn.params == %{"fulfillment" => %{}}

        Plug.Conn.resp(conn, 200, "{\"fulfillment\": {}}")
      end)

      ExShopify.Fulfillment.create(session, 1, %{})
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/orders/2/fulfillments/1.json"

        Plug.Conn.resp(conn, 200, "{\"fulfillment\": {}}")
      end)

      ExShopify.Fulfillment.find(session, 1, 2)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/orders/1/fulfillments.json"

        Plug.Conn.resp(conn, 200, "{\"fulfillments\": [{}]}")
      end)

      ExShopify.Fulfillment.list(session, 1)
    end
  end

  describe "open" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/orders/2/fulfillments/1/open.json"

        Plug.Conn.resp(conn, 200, "{\"fulfillment\": {}}")
      end)

      ExShopify.Fulfillment.open(session, 1, 2)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/orders/2/fulfillments/1.json"
        assert conn.params == %{"fulfillment" => %{}}

        Plug.Conn.resp(conn, 200, "{\"fulfillment\": {}}")
      end)

      ExShopify.Fulfillment.update(session, 1, 2, %{})
    end
  end
end
