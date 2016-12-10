defmodule ExShopifyTest.Refund do
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
        assert conn.request_path == "/admin/orders/1/refunds.json"
        assert conn.params == %{"refund" => %{}}

        Plug.Conn.resp(conn, 200, "{\"refund\": {}}")
      end)

      ExShopify.Refund.create(session, 1, %{})
    end
  end

  describe "calculate" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/orders/1/refunds/calculate.json"
        assert conn.params == %{"refund" => %{}}

        Plug.Conn.resp(conn, 200, "{\"refund\": {}}")
      end)

      ExShopify.Refund.calculate(session, 1, %{})
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/orders/2/refunds/1.json"

        Plug.Conn.resp(conn, 200, "{\"refund\":{}}")
      end)

      ExShopify.Refund.find(session, 1, 2)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/orders/1/refunds.json"

        Plug.Conn.resp(conn, 200, "{\"refunds\":[{}]}")
      end)

      ExShopify.Refund.list(session, 1)
    end
  end
end
