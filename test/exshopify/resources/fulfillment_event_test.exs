defmodule ExShopifyTest.FulfillmentEvent do
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
        assert conn.request_path == "/admin/orders/2/fulfillments/1/events.json"
        assert conn.params == %{"event" => %{}}

        Plug.Conn.resp(conn, 200, "{\"fulfillment_event\": {}}")
      end)

      ExShopify.FulfillmentEvent.create(session, 1, 2, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/orders/3/fulfillments/2/events/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.FulfillmentEvent.delete(session, 1, 2, 3)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/orders/3/fulfillments/2/events/1.json"

        Plug.Conn.resp(conn, 200, "{\"fulfillment_event\": {}}")
      end)

      ExShopify.FulfillmentEvent.find(session, 1, 2, 3)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/orders/2/fulfillments/1/events.json"

        Plug.Conn.resp(conn, 200, "{\"fulfillment_events\": [{}]}")
      end)

      ExShopify.FulfillmentEvent.list(session, 1, 2)
    end
  end
end
