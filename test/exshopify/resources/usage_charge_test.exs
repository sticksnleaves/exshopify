defmodule ExShopifyTest.UsageCharge do
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
        assert conn.request_path == "/admin/recurring_application_charges/1/usage_charges.json"
        assert conn.params == %{"usage_charge" => %{}}

        Plug.Conn.resp(conn, 200, "{\"usage_charge\": {}}")
      end)

      ExShopify.UsageCharge.create(session, 1, %{})
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/recurring_application_charges/2/usage_charges/1.json"

        Plug.Conn.resp(conn, 200, "{\"usage_charge\":{}}")
      end)

      ExShopify.UsageCharge.find(session, 1, 2)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/recurring_application_charges/1/usage_charges.json"

        Plug.Conn.resp(conn, 200, "{\"usage_charges\":[{}]}")
      end)

      ExShopify.UsageCharge.list(session, 1)
    end
  end
end
