defmodule ExShopifyTest.CarrierService do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open
    session = ExShopify.Session.new(%{port: bypass.port})

    {:ok, bypass: bypass, session: session}
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/carrier_services.json"

        Plug.Conn.resp(conn, 200, "{\"carrier_service\": {}}")
      end)

      ExShopify.CarrierService.create(session, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/carrier_services/1.json"

        Plug.Conn.resp(conn, 200, "{\"carrier_service\": {}}")
      end)

      ExShopify.CarrierService.delete(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/carrier_services/1.json"

        Plug.Conn.resp(conn, 200, "{\"carrier_service\": {}}")
      end)

      ExShopify.CarrierService.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/carrier_services.json"

        Plug.Conn.resp(conn, 200, "{\"carrier_services\": [{}]}")
      end)

      ExShopify.CarrierService.list(session)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "PUT"
        assert conn.request_path == "/admin/carrier_services/1.json"

        Plug.Conn.resp(conn, 200, "{\"carrier_service\": {}}")
      end)

      ExShopify.CarrierService.update(session, 1, %{})
    end
  end
end
