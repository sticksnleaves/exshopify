defmodule ExShopifyTest.Shop do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open
    session = ExShopify.Session.new(%{port: bypass.port})

    {:ok, bypass: bypass, session: session}
  end

  describe "get" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/shop.json"

        Plug.Conn.resp(conn, 200, "{\"shop\":{}}")
      end)

      ExShopify.Shop.get(session)
    end
  end
end
