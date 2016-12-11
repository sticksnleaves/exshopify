defmodule ExShopifyTest.SmartCollection do
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
        assert conn.request_path == "/admin/smart_collections/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\": 1}")
      end)

      ExShopify.SmartCollection.count(session)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/smart_collections.json"
        assert conn.params == %{"smart_collection" => %{}}

        Plug.Conn.resp(conn, 200, "{\"smart_collection\": {}}")
      end)

      ExShopify.SmartCollection.create(session, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/smart_collections/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.SmartCollection.delete(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/smart_collections/1.json"

        Plug.Conn.resp(conn, 200, "{\"smart_collection\": {}}")
      end)

      ExShopify.SmartCollection.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/smart_collections.json"

        Plug.Conn.resp(conn, 200, "{\"smart_collections\": [{}]}")
      end)

      ExShopify.SmartCollection.list(session)
    end
  end

  describe "order" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "PUT"
        assert conn.request_path == "/admin/smart_collections/1/order.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.SmartCollection.order(session, 1, %{})
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/smart_collections/1.json"
        assert conn.params == %{"smart_collection" => %{}}

        Plug.Conn.resp(conn, 200, "{\"smart_collection\": {}}")
      end)

      ExShopify.SmartCollection.update(session, 1, %{})
    end
  end
end
