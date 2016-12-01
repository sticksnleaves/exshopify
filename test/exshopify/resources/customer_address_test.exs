defmodule ExShopifyTest.CustomerAddress do
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
        assert conn.request_path == "/admin/customers/1/addresses.json"
        assert conn.params == %{"address" => %{}}

        Plug.Conn.resp(conn, 200, "{\"address\": {}}")
      end)

      ExShopify.CustomerAddress.create(session, 1, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/customers/2/addresses/1.json"

        Plug.Conn.resp(conn, 200, "{\"address\": {}}")
      end)

      ExShopify.CustomerAddress.delete(session, 1, 2)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/customers/2/addresses/1.json"

        Plug.Conn.resp(conn, 200, "{\"address\": {}}")
      end)

      ExShopify.CustomerAddress.find(session, 1, 2)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/customers/1/addresses.json"

        Plug.Conn.resp(conn, 200, "{\"addresses\": [{}]}")
      end)

      ExShopify.CustomerAddress.list(session, 1)
    end
  end

  describe "set_default" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "PUT"
        assert conn.request_path == "/admin/customers/2/addresses/1/default.json"

        Plug.Conn.resp(conn, 200, "{\"address\": {}}")
      end)

      ExShopify.CustomerAddress.set_default(session, 1, 2)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/customers/2/addresses/1.json"
        assert conn.params == %{"address" => %{}}

        Plug.Conn.resp(conn, 200, "{\"address\": {}}")
      end)

      ExShopify.CustomerAddress.update(session, 1, 2, %{})
    end
  end
end
