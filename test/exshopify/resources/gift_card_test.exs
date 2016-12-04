defmodule ExShopifyTest.GiftCard do
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
        assert conn.request_path == "/admin/gift_cards.json"
        assert conn.params == %{"gift_card" => %{}}

        Plug.Conn.resp(conn, 200, "{\"gift_card\": {}}")
      end)

      ExShopify.GiftCard.create(session, %{})
    end
  end

  describe "count" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/gift_cards/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\": 1}")
      end)

      ExShopify.GiftCard.count(session)
    end
  end

  describe "disable" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/gift_cards/1/disable.json"

        Plug.Conn.resp(conn, 200, "{\"gift_card\": {}}")
      end)

      ExShopify.GiftCard.disable(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/gift_cards/1.json"

        Plug.Conn.resp(conn, 200, "{\"gift_card\": {}}")
      end)

      ExShopify.GiftCard.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/gift_cards.json"

        Plug.Conn.resp(conn, 200, "{\"gift_cards\": [{}]}")
      end)

      ExShopify.GiftCard.list(session)
    end
  end

  describe "search" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/gift_cards/search.json"

        Plug.Conn.resp(conn, 200, "{\"gift_cards\": [{}]}")
      end)

      ExShopify.GiftCard.search(session, %{})
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/gift_cards/1.json"
        assert conn.params == %{"gift_card" => %{}}

        Plug.Conn.resp(conn, 200, "{\"gift_card\": {}}")
      end)

      ExShopify.GiftCard.update(session, 1, %{})
    end
  end
end
