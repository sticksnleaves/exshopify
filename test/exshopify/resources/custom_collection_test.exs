defmodule ExShopifyTest.CustomCollection do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open
    session = ExShopify.Session.new(%{port: bypass.port})

    {:ok, bypass: bypass, session: session}
  end

  describe "count" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "GET"
        assert conn.request_path == "/admin/custom_collections/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\": 1}")
      end)

      ExShopify.CustomCollection.count(session)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/custom_collections.json"
        assert conn.params == %{"custom_collection" => %{}}

        Plug.Conn.resp(conn, 200, "{\"custom_collection\": {}}")
      end)

      ExShopify.CustomCollection.create(session, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/custom_collections/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.CustomCollection.delete(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/custom_collections/1.json"

        Plug.Conn.resp(conn, 200, "{\"custom_collection\": {}}")
      end)

      ExShopify.CustomCollection.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/custom_collections.json"

        Plug.Conn.resp(conn, 200, "{\"custom_collections\": [{}]}")
      end)

      ExShopify.CustomCollection.list(session)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/custom_collections/1.json"
        assert conn.params == %{"custom_collection" => %{}}

        Plug.Conn.resp(conn, 200, "{\"custom_collection\": {}}")
      end)

      ExShopify.CustomCollection.update(session, 1, %{})
    end
  end
end
