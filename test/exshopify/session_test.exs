defmodule ExShopify.Session.Test do
  use ExUnit.Case

  setup do
    Application.stop(:exshopify)
    Application.start(:exshopify)
  end

  @moduletag :capture_log

  describe "ExShopify.Session.new/0" do
    test ":access_token returns application config" do
      Application.put_env(:exshopify, :access_token, "access_token")

      session = ExShopify.Session.new

      assert session.access_token == Application.get_env(:exshopify, :access_token)
    end

    test ":api_key returns application config" do
      Application.put_env(:exshopify, :api_key, "api_key")

      session = ExShopify.Session.new

      assert session.api_key == Application.get_env(:exshopify, :api_key)
    end

    test ":domain returns application config" do
      Application.put_env(:exshopify, :domain, "domain")

      session = ExShopify.Session.new

      assert session.domain == Application.get_env(:exshopify, :domain)
    end

    test ":port returns application config" do
      Application.put_env(:exshopify, :port, "port")

      session = ExShopify.Session.new

      assert session.port == Application.get_env(:exshopify, :port)
    end

    test ":protocol returns application config" do
      Application.put_env(:exshopify, :protocol, "protocol")

      session = ExShopify.Session.new

      assert session.protocol == Application.get_env(:exshopify, :protocol)
    end

    test ":secret returns application config" do
      Application.put_env(:exshopify, :secret, "secret")

      session = ExShopify.Session.new

      assert session.secret == Application.get_env(:exshopify, :secret)
    end

    test ":shop_name returns application config" do
      Application.put_env(:exshopify, :shop_name, "shop_name")

      session = ExShopify.Session.new

      assert session.shop_name == Application.get_env(:exshopify, :shop_name)
    end

    test ":shop_url returns application config" do
      Application.put_env(:exshopify, :shop_url, "shop_url")

      session = ExShopify.Session.new

      assert session.shop_url == Application.get_env(:exshopify, :shop_url)
    end
  end

  describe "ExShopify.Session.new/1" do
    test ":access_token returns provided value" do
      value = "access_token"

      session = ExShopify.Session.new(access_token: value)

      assert session.access_token == value
    end

    test ":api_key returns provided value" do
      value = "api_key"

      session = ExShopify.Session.new(api_key: value)

      assert session.api_key == value
    end

    test ":domain returns provided value" do
      value = "domain"

      session = ExShopify.Session.new(domain: value)

      assert session.domain == value
    end

    test ":port returns provided value" do
      value = "port"

      session = ExShopify.Session.new(port: value)

      assert session.port == value
    end

    test ":protocol returns provided value" do
      value = "protocol"

      session = ExShopify.Session.new(protocol: value)

      assert session.protocol == value
    end

    test ":secret returns provided value" do
      value = "secret"

      session = ExShopify.Session.new(secret: value)

      assert session.secret == value
    end

    test ":shop_name returns provided value" do
      value = "shop_name"

      session = ExShopify.Session.new(shop_name: value)

      assert session.shop_name == value
    end

    test ":shop_url returns provided value" do
      value = "shop_url"

      session = ExShopify.Session.new(shop_url: value)

      assert session.shop_url == value
    end

    test "params override application config" do
      Application.put_env(:exshopify, :access_token, 1)

      session = ExShopify.Session.new(access_token: 2)

      assert session.access_token == 2
    end
  end
end
