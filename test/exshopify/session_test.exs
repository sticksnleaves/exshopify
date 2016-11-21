defmodule ExShopify.Session.Test do
  use ExUnit.Case, async: true

  describe "ExShopify.Session.create/0" do
    test ":access_token returns application config" do
      Application.put_env(:exshopify, :access_token, "access_token")

      value = ExShopify.Session.create()[:access_token]

      assert value == Application.get_env(:exshopify, :access_token)
    end

    test ":api_key returns application config" do
      Application.put_env(:exshopify, :api_key, "api_key")

      value = ExShopify.Session.create()[:api_key]

      assert value == Application.get_env(:exshopify, :api_key)
    end

    test ":shared_secret returns application config" do
      Application.put_env(:exshopify, :shared_secret, "shared_secret")

      value = ExShopify.Session.create()[:shared_secret]

      assert value == Application.get_env(:exshopify, :shared_secret)
    end

    test ":shop_name returns application config" do
      Application.put_env(:exshopify, :shop_name, "shop_name")

      value = ExShopify.Session.create()[:shop_name]

      assert value == Application.get_env(:exshopify, :shop_name)
    end

    test ":shop_url returns application config" do
      Application.put_env(:exshopify, :shop_url, "shop_url")

      value = ExShopify.Session.create()[:shop_url]

      assert value == Application.get_env(:exshopify, :shop_url)
    end
  end

  describe "ExShopify.Session.create/1" do
    test ":access_token returns provided value" do
      value = "access_token"

      assert ExShopify.Session.create(access_token: value)[:access_token] == value
    end

    test ":api_key returns provided value" do
      value = "api_key"

      assert ExShopify.Session.create(api_key: value)[:api_key] == value
    end

    test ":shared_secret returns provided value" do
      value = "shared_secret"

      assert ExShopify.Session.create(shared_secret: value)[:shared_secret] == value
    end

    test ":shop_name returns provided value" do
      value = "shop_name"

      assert ExShopify.Session.create(shop_name: value)[:shop_name] == value
    end

    test ":shop_url returns provided value" do
      value = "shop_url"

      assert ExShopify.Session.create(shop_url: value)[:shop_url] == value
    end

    test "params override application config" do
      Application.put_env(:exshopify, :access_token, 1)

      assert ExShopify.Session.create(access_token: 2)[:access_token] == 2
    end
  end
end
