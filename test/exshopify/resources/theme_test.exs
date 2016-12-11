defmodule ExShopifyTest.Theme do
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
        assert conn.request_path == "/admin/themes.json"
        assert conn.params == %{"theme" => %{}}

        Plug.Conn.resp(conn, 200, "{\"theme\": {}}")
      end)

      ExShopify.Theme.create(session, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/themes/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.Theme.delete(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/themes/1.json"

        Plug.Conn.resp(conn, 200, "{\"theme\":{}}")
      end)

      ExShopify.Theme.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/themes.json"

        Plug.Conn.resp(conn, 200, "{\"themes\":[{}]}")
      end)

      ExShopify.Theme.list(session)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/themes/1.json"
        assert conn.params == %{"theme" => %{}}

        Plug.Conn.resp(conn, 200, "{\"theme\": {}}")
      end)

      ExShopify.Theme.update(session, 1, %{})
    end
  end
end
