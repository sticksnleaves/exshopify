defmodule ExShopifyTest.Customer do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open
    session = ExShopify.Session.new(%{port: bypass.port})

    {:ok, bypass: bypass, session: session}
  end

  describe "account_activation_url" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/customers/1/account_activation_url.json"

        Plug.Conn.resp(conn, 200, "{\"account_activation_url\": \"\"}")
      end)

      ExShopify.Customer.account_activation_url(session, 1)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/customers.json"
        assert conn.params == %{"customer" => %{}}

        Plug.Conn.resp(conn, 200, "{\"customer\": {}}")
      end)

      ExShopify.Customer.create(session, %{})
    end
  end

  describe "count" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/customers/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\": 1}")
      end)

      ExShopify.Customer.count(session)
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/customers/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.Customer.delete(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/customers/1.json"

        Plug.Conn.resp(conn, 200, "{\"customer\": {}}")
      end)

      ExShopify.Customer.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/customers.json"

        Plug.Conn.resp(conn, 200, "{\"customers\": [{}]}")
      end)

      ExShopify.Customer.list(session)
    end
  end

  describe "search" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/customers/search.json"
        assert conn.query_string == "query=test"

        Plug.Conn.resp(conn, 200, "{\"customers\": [{}]}")
      end)

      ExShopify.Customer.search(session, "test")
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/customers/1.json"
        assert conn.params == %{"customer" => %{}}

        Plug.Conn.resp(conn, 200, "{\"customer\": {}}")
      end)

      ExShopify.Customer.update(session, 1, %{})
    end
  end
end
