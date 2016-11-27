defmodule ExShopifyTest.ApplicationCredit do
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
        assert conn.request_path == "/admin/application_credits.json"

        Plug.Conn.resp(conn, 200, "{\"application_credit\": {}}")
      end)

      ExShopify.ApplicationCredit.create(session, %{})
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/application_credits/1.json"

        Plug.Conn.resp(conn, 200, "{\"application_credit\": {}}")
      end)

      ExShopify.ApplicationCredit.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/application_credits.json"

        Plug.Conn.resp(conn, 200, "{\"application_credits\": [{}]}")
      end)

      ExShopify.ApplicationCredit.list(session)
    end
  end
end
