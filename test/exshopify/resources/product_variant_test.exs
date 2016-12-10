defmodule ExShopifyTest.ProductVariant do
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
        assert conn.request_path == "/admin/products/1/variants/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\":1}")
      end)

      ExShopify.ProductVariant.count(session, 1)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/products/1/variants.json"
        assert conn.params == %{"variant" => %{}}

        Plug.Conn.resp(conn, 200, "{\"variant\": {}}")
      end)

      ExShopify.ProductVariant.create(session, 1, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/products/2/variants/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.ProductVariant.delete(session, 1, 2)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/variants/1.json"

        Plug.Conn.resp(conn, 200, "{\"variant\":{}}")
      end)

      ExShopify.ProductVariant.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/products/1/variants.json"

        Plug.Conn.resp(conn, 200, "{\"variants\":[{}]}")
      end)

      ExShopify.ProductVariant.list(session, 1)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/variants/1.json"
        assert conn.params == %{"variant" => %{}}

        Plug.Conn.resp(conn, 200, "{\"variant\": {}}")
      end)

      ExShopify.ProductVariant.update(session, 1, %{})
    end
  end
end
