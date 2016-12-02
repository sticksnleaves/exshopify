defmodule ExShopifyTest.Discount do
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
        assert conn.request_path == "/admin/discounts.json"
        assert conn.params == %{"discount" => %{}}

        Plug.Conn.resp(conn, 200, "{\"discount\": {}}")
      end)

      ExShopify.Discount.create(session, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/discounts/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.Discount.delete(session, 1)
    end
  end

  describe "disable" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/discounts/1/disable.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.Discount.disable(session, 1)
    end
  end

  describe "enable" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/discounts/1/enable.json"

        Plug.Conn.resp(conn, 200, "{\"discount\": {}}")
      end)

      ExShopify.Discount.enable(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/discounts/1.json"

        Plug.Conn.resp(conn, 200, "{\"discount\": {}}")
      end)

      ExShopify.Discount.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/discounts.json"

        Plug.Conn.resp(conn, 200, "{\"discounts\": [{}]}")
      end)

      ExShopify.Discount.list(session)
    end
  end
end
