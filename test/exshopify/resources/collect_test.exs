defmodule ExShopifyTest.Collect do
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
        assert conn.request_path == "/admin/collects/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\": 1}")
      end)

      ExShopify.Collect.count(session)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/collects.json"

        Plug.Conn.resp(conn, 200, "{\"collect\": {}}")
      end)

      ExShopify.Collect.create(session, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/collects/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.Collect.delete(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/collects/1.json"

        Plug.Conn.resp(conn, 200, "{\"collect\": {}}")
      end)

      ExShopify.Collect.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/collects.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.Collect.list(session)
    end
  end
end
