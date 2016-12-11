defmodule ExShopifyTest.User do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open
    session = ExShopify.Session.new(%{port: bypass.port})

    {:ok, bypass: bypass, session: session}
  end

  describe "current" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/users/current.json"

        Plug.Conn.resp(conn, 200, "{\"user\": {}}")
      end)

      ExShopify.User.current(session)
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/users/1.json"

        Plug.Conn.resp(conn, 200, "{\"user\":{}}")
      end)

      ExShopify.User.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/users.json"

        Plug.Conn.resp(conn, 200, "{\"users\":[{}]}")
      end)

      ExShopify.User.list(session)
    end
  end
end
