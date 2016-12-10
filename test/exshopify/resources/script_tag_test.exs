defmodule ExShopifyTest.ScriptTag do
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
        assert conn.request_path == "/admin/script_tags/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\":1}")
      end)

      ExShopify.ScriptTag.count(session)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/script_tags.json"
        assert conn.params == %{"script_tag" => %{}}

        Plug.Conn.resp(conn, 200, "{\"script_tag\": {}}")
      end)

      ExShopify.ScriptTag.create(session, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/script_tags/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.ScriptTag.delete(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/script_tags/1.json"

        Plug.Conn.resp(conn, 200, "{\"script_tag\":{}}")
      end)

      ExShopify.ScriptTag.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/script_tags.json"

        Plug.Conn.resp(conn, 200, "{\"script_tags\":[{}]}")
      end)

      ExShopify.ScriptTag.list(session)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/script_tags/1.json"
        assert conn.params == %{"script_tag" => %{}}

        Plug.Conn.resp(conn, 200, "{\"script_tag\": {}}")
      end)

      ExShopify.ScriptTag.update(session, 1, %{})
    end
  end
end
