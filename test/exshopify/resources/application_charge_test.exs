defmodule ExShopifyTest.ApplicationCharge do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open
    session = ExShopify.Session.new(%{port: bypass.port})

    {:ok, bypass: bypass, session: session}
  end

  describe "activate" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/application_charges/1/activate.json"

        Plug.Conn.resp(conn, 200, "{\"application_charge\": {}}")
      end)

      ExShopify.ApplicationCharge.activate(session, 1, %{})
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/application_charges.json"

        Plug.Conn.resp(conn, 200, "{\"application_charge\": {}}")
      end)

      ExShopify.ApplicationCharge.create(session, %{})
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/application_charges/1.json"

        Plug.Conn.resp(conn, 200, "{\"application_charge\": {}}")
      end)

      ExShopify.ApplicationCharge.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/application_charges.json"

        Plug.Conn.resp(conn, 200, "{\"application_charges\": [{}]}")
      end)

      ExShopify.ApplicationCharge.list(session)
    end
  end
end
