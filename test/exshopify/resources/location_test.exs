defmodule ExShopifyTest.Location do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open
    session = ExShopify.Session.new(%{port: bypass.port})

    {:ok, bypass: bypass, session: session}
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/locations/1.json"

        Plug.Conn.resp(conn, 200, "{\"location\": {}}")
      end)

      ExShopify.Location.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/locations.json"

        Plug.Conn.resp(conn, 200, "{\"locations\": [{}]}")
      end)

      ExShopify.Location.list(session)
    end
  end
end
