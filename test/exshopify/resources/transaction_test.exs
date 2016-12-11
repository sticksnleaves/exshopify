defmodule ExShopifyTest.Transaction do
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
        assert conn.request_path == "/admin/orders/1/transactions/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\":1}")
      end)

      ExShopify.Transaction.count(session, 1)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/orders/1/transactions.json"
        assert conn.params == %{"transaction" => %{}}

        Plug.Conn.resp(conn, 200, "{\"transaction\": {}}")
      end)

      ExShopify.Transaction.create(session, 1, %{})
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/orders/2/transactions/1.json"

        Plug.Conn.resp(conn, 200, "{\"transaction\":{}}")
      end)

      ExShopify.Transaction.find(session, 1, 2)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/orders/1/transactions.json"

        Plug.Conn.resp(conn, 200, "{\"transactions\":[{}]}")
      end)

      ExShopify.Transaction.list(session, 1)
    end
  end
end
