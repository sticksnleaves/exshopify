# ExShopify

[![Build Status](https://travis-ci.org/sticksnleaves/exshopify.svg?branch=master)](https://travis-ci.org/sticksnleaves/exshopify)

Exlixir client for accessing the Shopify admin REST web services.

## Installation

The package can be installed as:

  1. Add `exshopify` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:exshopify, "~> 1.0.0"}]
    end
    ```

  2. Ensure `exshopify` is started before your application:

    ```elixir
    def application do
      [applications: [:exshopify]]
    end
    ```

## Usage

### Sessions

Sessions are responsible for telling ExShopify how to connect to Shopify's API.
All requests made with ExShopify expect a session to be passed as the first
argument.

Creating an `ExShopify.Session` is easy:

```elixir
iex> ExShopify.Session.new
```

A session is just a simple struct that defines the following fields:

  * `access_token`
  * `api_key`
  * `domain`
  * `port`
  * `protocol`
  * `secret`
  * `shop_name`
  * `shop_url`

It's possible to define values for these fields either programmatically:

```elixir
iex> ExShopify.Session.new(shop_name: "elixirshopify")
%ExShopify.Session{shop_name: "elixirshopify"}
```

or through the app configuration:

```elixir
# config/config.exs

config :exshopify, shop_name: "elixirshopify"

...

iex> ExShopify.Session.new
%ExShopify.Session{shop_name: "elixirshopify"}
```

*NOTE* that arguments passed to `new/1` will always override the app
configuration.

### Private Applications

To configure ExShopify for use with a private application all you will need
to do is provide a `shop_url` to the session.

```elixir
config :exconfig, shop_url: "https://#{api_key}:#{password}@#{shop_name}.myshopify.com/admin")

...

{:ok, order, meta} = ExShopify.Order.find(ExShopify.Session.new, 450789469)
```

### Partner Applications

Partner applications need to go through the
[Shopify OAuth flow](https://help.shopify.com/api/guides/authentication/oauth)
in order to authenticate a session to shop.
