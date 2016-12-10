defmodule ExShopifyTest.ShippingZone do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open
    session = ExShopify.Session.new(%{port: bypass.port})

    {:ok, bypass: bypass, session: session}
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/shipping_zones.json"

        Plug.Conn.resp(conn, 200, "{\"shipping_zones\":[{}]}")
      end)

      ExShopify.ShippingZone.list(session)
    end
  end
end
