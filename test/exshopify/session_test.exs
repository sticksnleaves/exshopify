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

    test ":domain returns application config" do
      Application.put_env(:exshopify, :domain, "domain")

      value = ExShopify.Session.create()[:domain]

      assert value == Application.get_env(:exshopify, :domain)
    end

    test ":port returns application config" do
      Application.put_env(:exshopify, :port, "port")

      value = ExShopify.Session.create()[:port]

      assert value == Application.get_env(:exshopify, :port)
    end

    test ":protocol returns application config" do
      Application.put_env(:exshopify, :protocol, "protocol")

      value = ExShopify.Session.create()[:protocol]

      assert value == Application.get_env(:exshopify, :protocol)
    end

    test ":secret returns application config" do
      Application.put_env(:exshopify, :secret, "secret")

      value = ExShopify.Session.create()[:secret]

      assert value == Application.get_env(:exshopify, :secret)
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

    test ":domain returns provided value" do
      value = "domain"

      assert ExShopify.Session.create(domain: value)[:domain] == value
    end

    test ":port returns provided value" do
      value = "port"

      assert ExShopify.Session.create(port: value)[:port] == value
    end

    test ":protocol returns provided value" do
      value = "protocol"

      assert ExShopify.Session.create(protocol: value)[:protocol] == value
    end

    test ":secret returns provided value" do
      value = "secret"

      assert ExShopify.Session.create(secret: value)[:secret] == value
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
