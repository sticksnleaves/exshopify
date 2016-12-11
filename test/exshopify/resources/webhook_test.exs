defmodule ExShopifyTest.Webhook do
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
        assert conn.request_path == "/admin/webhooks/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\":1}")
      end)

      ExShopify.Webhook.count(session)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/webhooks.json"
        assert conn.params == %{"webhook" => %{}}

        Plug.Conn.resp(conn, 200, "{\"webhook\": {}}")
      end)

      ExShopify.Webhook.create(session, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/webhooks/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.Webhook.delete(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/webhooks/1.json"

        Plug.Conn.resp(conn, 200, "{\"webhook\":{}}")
      end)

      ExShopify.Webhook.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/webhooks.json"

        Plug.Conn.resp(conn, 200, "{\"webhooks\":[{}]}")
      end)

      ExShopify.Webhook.list(session)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/webhooks/1.json"
        assert conn.params == %{"webhook" => %{}}

        Plug.Conn.resp(conn, 200, "{\"webhook\": {}}")
      end)

      ExShopify.Webhook.update(session, 1, %{})
    end
  end
end
