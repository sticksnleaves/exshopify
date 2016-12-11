defmodule ExShopifyTest.AccessToken do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open

    {:ok, bypass: bypass}
  end

  describe "create" do
    test "endpoint", %{bypass: bypass} do
      Bypass.expect(bypass, fn(conn) ->
        conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.JSON], json_decoder: Poison)

        assert conn.method == "POST"
        assert conn.request_path == "/admin/oauth/access_token"

        assert conn.body_params["client_id"] == "api_key"
        assert conn.body_params["client_secret"] == "secret"
        assert conn.body_params["code"] == 1234

        Plug.Conn.resp(conn, 200, "{\"access_token\":\"f85632530bf277ec9ac6f649fc327f17\", \"scope\":\"write_orders,read_customers\"}")
      end)

      session = ExShopify.Session.new(api_key: "api_key", secret: "secret", port: bypass.port)
      {:ok, access_token, _meta} = ExShopify.AccessToken.create(session, 1234)

      assert access_token.access_token == "f85632530bf277ec9ac6f649fc327f17"
      assert access_token.scope == "write_orders,read_customers"
    end
  end
end
