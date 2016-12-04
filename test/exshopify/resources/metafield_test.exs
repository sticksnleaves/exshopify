defmodule ExShopifyTest.Metafield do
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
        assert conn.request_path == "/admin/metafields/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\": 1}")
      end)

      ExShopify.Metafield.count(session)
    end
  end

  describe "count_from_product" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/products/1/metafields/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\": 1}")
      end)

      ExShopify.Metafield.count_from_product(session, 1)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/metafields.json"
        assert conn.params == %{"metafield" => %{}}

        Plug.Conn.resp(conn, 200, "{\"metafield\": {}}")
      end)

      ExShopify.Metafield.create(session, %{})
    end
  end

  describe "create_from_product" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/products/1/metafields.json"
        assert conn.params == %{"metafield" => %{}}

        Plug.Conn.resp(conn, 200, "{\"metafield\": {}}")
      end)

      ExShopify.Metafield.create_from_product(session, 1, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/metafields/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.Metafield.delete(session, 1)
    end
  end

  describe "delete_from_product" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/products/2/metafields/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.Metafield.delete_from_product(session, 1, 2)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/metafields/1.json"

        Plug.Conn.resp(conn, 200, "{\"metafield\": {}}")
      end)

      ExShopify.Metafield.find(session, 1)
    end
  end

  describe "find_from_product" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/products/2/metafields/1.json"

        Plug.Conn.resp(conn, 200, "{\"metafield\": {}}")
      end)

      ExShopify.Metafield.find_from_product(session, 1, 2)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/metafields.json"

        Plug.Conn.resp(conn, 200, "{\"metafields\": [{}]}")
      end)

      ExShopify.Metafield.list(session)
    end
  end

  describe "list_from_product" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/products/1/metafields.json"

        Plug.Conn.resp(conn, 200, "{\"metafields\": [{}]}")
      end)

      ExShopify.Metafield.list_from_product(session, 1)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/metafields/1.json"
        assert conn.params == %{"metafield" => %{}}

        Plug.Conn.resp(conn, 200, "{\"metafield\": {}}")
      end)

      ExShopify.Metafield.update(session, 1, %{})
    end
  end

  describe "update_from_product" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/products/2/metafields/1.json"
        assert conn.params == %{"metafield" => %{}}

        Plug.Conn.resp(conn, 200, "{\"metafield\": {}}")
      end)

      ExShopify.Metafield.update_from_product(session, 1, 2, %{})
    end
  end
end
