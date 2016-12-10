defmodule ExShopifyTest.Province do
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
        assert conn.request_path == "/admin/countries/1/provinces/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\":1}")
      end)

      ExShopify.Province.count(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/countries/2/provinces/1.json"

        Plug.Conn.resp(conn, 200, "{\"province\":{}}")
      end)

      ExShopify.Province.find(session, 1, 2)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/countries/1/provinces.json"

        Plug.Conn.resp(conn, 200, "{\"provinces\":[{}]}")
      end)

      ExShopify.Province.list(session, 1)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/countries/2/provinces/1.json"
        assert conn.params == %{"province" => %{}}

        Plug.Conn.resp(conn, 200, "{\"province\": {}}")
      end)

      ExShopify.Province.update(session, 1, 2, %{})
    end
  end
end
