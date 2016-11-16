defmodule ExShopifyTest do
  use ExUnit.Case, async: true

  use Plug.Test

  doctest ExShopify

  test "should raise an ArgumentError if \"strategy\" option is not provided" do
    assert_raise(ArgumentError, "ExShopify.Plug expected a strategy of :oauth or :webhook", fn ->
      conn(:get, "/", %{}) |> ExShopify.Plug.call(%{})
    end)
  end

  test "should raise an ArgumentError if \"strategy\" option is not one of :oauth or :webhook" do
    assert_raise(ArgumentError, "ExShopify.Plug expected a strategy of :oauth or :webhook", fn ->
      conn(:get, "/", %{}) |> ExShopify.Plug.call(%{strategy: :nope})
    end)
  end

  test "it should raise an ArgumentError if \"shared_secret\"  is nil" do
    assert_raise(ArgumentError, "ExShopify.Plug expected a shared_secret", fn ->
      conn(:get, "/", %{}) |> ExShopify.Plug.call(%{strategy: :oauth})
    end)
  end

  describe ":oauth strategy" do
    test "should assign \"shopify_hmac_verified\" to \"true\" if HMAC is valid" do
      opts = %{
        shared_secret: "hush",
        strategy: :oauth
      }

      params = %{
        code: "0907a61c0c8d55e99db179b68161bc00",
        hmac: "4712bf92ffc2917d15a2f5a273e39f0116667419aa4b6ac0b3baaf26fa3c4d20",
        shop: "some-shop.myshopify.com",
        timestamp: "1337178173"
      }

      conn = conn(:get, "/", params) |> ExShopify.Plug.call(opts)

      assert(conn.assigns[:shopify_hmac_verified] == true)
    end

    test "should assign \"shopify_hmac_verified\" to \"false\" if HMAC is invalid" do
      opts = %{
        shared_secret: "invalid",
        strategy: :oauth
      }

      params = %{
        code: "0907a61c0c8d55e99db179b68161bc00",
        hmac: "4712bf92ffc2917d15a2f5a273e39f0116667419aa4b6ac0b3baaf26fa3c4d20",
        shop: "some-shop.myshopify.com",
        timestamp: "1337178173"
      }

      conn = conn(:get, "/", params) |> ExShopify.Plug.call(opts)

      assert(conn.assigns[:shopify_hmac_verified] == false)
    end
  end
end
