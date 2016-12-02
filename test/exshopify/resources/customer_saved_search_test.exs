defmodule ExShopifyTest.CustomerSavedSearch do
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
        assert conn.request_path == "/admin/customer_saved_searches/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\": 1}")
      end)

      ExShopify.CustomerSavedSearch.count(session)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/customer_saved_searches.json"
        assert conn.params == %{"customer_saved_search" => %{}}

        Plug.Conn.resp(conn, 200, "{\"customer_saved_searches\": {}}")
      end)

      ExShopify.CustomerSavedSearch.create(session, %{})
    end
  end

  describe "customers" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/customer_saved_searches/1/customers.json"

        Plug.Conn.resp(conn, 200, "{\"customers\": [{}]}")
      end)

      ExShopify.CustomerSavedSearch.customers(session, 1)
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/customer_saved_searches/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.CustomerSavedSearch.delete(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/customer_saved_searches/1.json"

        Plug.Conn.resp(conn, 200, "{\"customer_saved_search\": {}}")
      end)

      ExShopify.CustomerSavedSearch.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/customer_saved_searches.json"

        Plug.Conn.resp(conn, 200, "{\"customer_saved_searches\": [{}]}")
      end)

      ExShopify.CustomerSavedSearch.list(session)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/customer_saved_searches/1.json"
        assert conn.params == %{"customer_saved_search" => %{}}

        Plug.Conn.resp(conn, 200, "{\"customer_saved_search\": {}}")
      end)

      ExShopify.CustomerSavedSearch.update(session, 1, %{})
    end
  end
end
