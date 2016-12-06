defmodule ExShopifyTest.Page do
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
        assert conn.request_path == "/admin/pages/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\":1}")
      end)

      ExShopify.Page.count(session)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/pages.json"
        assert conn.params == %{"page" => %{}}

        Plug.Conn.resp(conn, 200, "{\"page\": {}}")
      end)

      ExShopify.Page.create(session, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/pages/1.json"

        Plug.Conn.resp(conn, 200, "{\"page\":{}}")
      end)

      ExShopify.Page.delete(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/pages/1.json"

        Plug.Conn.resp(conn, 200, "{\"page\":{}}")
      end)

      ExShopify.Page.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/pages.json"

        Plug.Conn.resp(conn, 200, "{\"pages\":[{}]}")
      end)

      ExShopify.Page.list(session)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/pages/1.json"
        assert conn.params == %{"page" => %{}}

        Plug.Conn.resp(conn, 200, "{\"page\": {}}")
      end)

      ExShopify.Page.update(session, 1, %{})
    end
  end
end
