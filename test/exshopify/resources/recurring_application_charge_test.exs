defmodule ExShopifyTest.RecurringRecurringApplicationCharge do
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
        assert conn.request_path == "/admin/recurring_application_charges/1/activate.json"

        Plug.Conn.resp(conn, 200, "{\"application_charge\": {}}")
      end)

      ExShopify.RecurringApplicationCharge.activate(session, 1)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/recurring_application_charges.json"
        assert conn.params == %{"recurring_application_charge" => %{}}

        Plug.Conn.resp(conn, 200, "{\"application_charge\": {}}")
      end)

      ExShopify.RecurringApplicationCharge.create(session, %{})
    end
  end

  describe "customize" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "PUT"
        assert conn.request_path == "/admin/recurring_application_charges/1/customize.json"
        assert conn.params == %{"recurring_application_charge" => %{}}

        Plug.Conn.resp(conn, 200, "{\"recurring_application_charge\": {}}")
      end)

      ExShopify.RecurringApplicationCharge.customize(session, 1, %{})
    end
  end

  describe "delete" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/admin/recurring_application_charges/1.json"

        Plug.Conn.resp(conn, 200, "{}")
      end)

      ExShopify.RecurringApplicationCharge.delete(session, 1)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/recurring_application_charges/1.json"

        Plug.Conn.resp(conn, 200, "{\"application_charge\": {}}")
      end)

      ExShopify.RecurringApplicationCharge.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/recurring_application_charges.json"

        Plug.Conn.resp(conn, 200, "{\"recurring_application_charges\": [{}]}")
      end)

      ExShopify.RecurringApplicationCharge.list(session)
    end
  end
end
