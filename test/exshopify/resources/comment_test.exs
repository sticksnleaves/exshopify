defmodule ExShopifyTest.Comment do
  use ExUnit.Case, async: true

  setup do
    bypass  = Bypass.open
    session = ExShopify.Session.new(%{port: bypass.port})

    {:ok, bypass: bypass, session: session}
  end

  describe "approve" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/comments/1/approve.json"

        Plug.Conn.resp(conn, 200, "{\"comment\": {}}")
      end)

      ExShopify.Comment.approve(session, 1)
    end
  end

  describe "count" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/comments/count.json"

        Plug.Conn.resp(conn, 200, "{\"count\": 1}")
      end)

      ExShopify.Comment.count(session)
    end
  end

  describe "create" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/comments.json"

        Plug.Conn.resp(conn, 200, "{\"comment\": {}}")
      end)

      ExShopify.Comment.create(session, %{})
    end
  end

  describe "find" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/comments/1.json"

        Plug.Conn.resp(conn, 200, "{\"comment\": {}}")
      end)

      ExShopify.Comment.find(session, 1)
    end
  end

  describe "list" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "GET"
        assert conn.request_path == "/admin/comments.json"

        Plug.Conn.resp(conn, 200, "{\"comments\": [{}]}")
      end)

      ExShopify.Comment.list(session)
    end
  end

  describe "mark_as_spam" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/comments/1/spam.json"

        Plug.Conn.resp(conn, 200, "{\"comment\": {}}")
      end)

      ExShopify.Comment.mark_as_spam(session, 1)
    end
  end

  describe "mark_as_not_spam" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/comments/1/not_spam.json"

        Plug.Conn.resp(conn, 200, "{\"comment\": {}}")
      end)

      ExShopify.Comment.mark_as_not_spam(session, 1)
    end
  end

  describe "remove" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/comments/1/remove.json"

        Plug.Conn.resp(conn, 200, "{\"comment\": {}}")
      end)

      ExShopify.Comment.remove(session, 1)
    end
  end

  describe "restore" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "POST"
        assert conn.request_path == "/admin/comments/1/restore.json"

        Plug.Conn.resp(conn, 200, "{\"comment\": {}}")
      end)

      ExShopify.Comment.restore(session, 1)
    end
  end

  describe "update" do
    test "endpoint", %{bypass: bypass, session: session} do
      Bypass.expect(bypass, fn(conn) ->
        assert conn.method == "PUT"
        assert conn.request_path == "/admin/comments/1.json"

        Plug.Conn.resp(conn, 200, "{\"comment\": {}}")
      end)

      ExShopify.Comment.update(session, 1, %{})
    end
  end
end
