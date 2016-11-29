defmodule ExShopifyTest.Blog do
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
        assert conn.request_path == "/admin/blogs/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\": 1}")
      end)

      ExShopify.Blog.count(session)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/blogs.json"

        Plug.Conn.resp(conn, 200, "{\"blog\": {}}")
      end)

      ExShopify.Blog.create(session, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/blogs/1.json"

        Plug.Conn.resp(conn, 200, "{\"blog\": {}}")
      end)

      ExShopify.Blog.delete(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/blogs/1.json"

        Plug.Conn.resp(conn, 200, "{\"blog\": {}}")
      end)

      ExShopify.Blog.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/blogs.json"

        Plug.Conn.resp(conn, 200, "{\"blogs\": [{}]}")
      end)

      ExShopify.Blog.list(session)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "PUT"
        assert conn.request_path == "/admin/blogs/1.json"

        Plug.Conn.resp(conn, 200, "{\"blog\": {}}")
      end)

      ExShopify.Blog.update(session, 1, %{})
    end
  end
end
