defmodule ExShopifyTest.Redirect do
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
        assert conn.request_path == "/admin/redirects/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\":1}")
      end)

      ExShopify.Redirect.count(session)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/redirects.json"
        assert conn.params == %{"redirect" => %{}}

        Plug.Conn.resp(conn, 200, "{\"redirect\": {}}")
      end)

      ExShopify.Redirect.create(session, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/redirects/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.Redirect.delete(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/redirects/1.json"

        Plug.Conn.resp(conn, 200, "{\"redirect\":{}}")
      end)

      ExShopify.Redirect.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/redirects.json"

        Plug.Conn.resp(conn, 200, "{\"redirects\":[{}]}")
      end)

      ExShopify.Redirect.list(session)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/redirects/1.json"
        assert conn.params == %{"redirect" => %{}}

        Plug.Conn.resp(conn, 200, "{\"redirect\": {}}")
      end)

      ExShopify.Redirect.update(session, 1, %{})
    end
  end
end
