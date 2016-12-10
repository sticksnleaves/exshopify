defmodule ExShopifyTest.Policy do
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
        assert conn.request_path == "/admin/policies.json"

        Plug.Conn.resp(conn, 200, "{\"policies\":[{}]}")
      end)

      ExShopify.Policy.list(session)
    end
  end
end
