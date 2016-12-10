defmodule ExShopifyTest.ProductImage do
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
        assert conn.request_path == "/admin/products/1/images/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\":1}")
      end)

      ExShopify.ProductImage.count(session, 1)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/products/1/images.json"
        assert conn.params == %{"image" => %{}}

        Plug.Conn.resp(conn, 200, "{\"image\": {}}")
      end)

      ExShopify.ProductImage.create(session, 1, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/products/2/images/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.ProductImage.delete(session, 1, 2)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/products/2/images/1.json"

        Plug.Conn.resp(conn, 200, "{\"image\":{}}")
      end)

      ExShopify.ProductImage.find(session, 1, 2)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/products/1/images.json"

        Plug.Conn.resp(conn, 200, "{\"images\":[{}]}")
      end)

      ExShopify.ProductImage.list(session, 1)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/products/2/images/1.json"
        assert conn.params == %{"image" => %{}}

        Plug.Conn.resp(conn, 200, "{\"image\": {}}")
      end)

      ExShopify.ProductImage.update(session, 1, 2, %{})
    end
  end
end
