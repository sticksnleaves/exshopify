# ExShopify

Elixir client for the Shopify REST API.

## Documentation

* [Latest HexDocs](https://hexdocs.pm/exshopify/api-reference.html)

## Installation

```elixir
def deps do
  [
    {:exshopify, "~> 0.3.0"},
    {:hackney, "~> 1.14"},
    {:jason, "~> 1.1"}
  ]
end
```

`ExShopify` allows you to use the HTTP client and JSON codec of your choice.
However, we support `hackney` and `jason` out of the box. If you would like to
use a different HTTP client or JSON codec please see
**(link to something here)**.

## Authentication

Shopify provides two authentication strategies when making API requests: public
and private.

Public apps allow you to interact with the Shopify API on behalf of multiple
stores. Private apps, on the other handle, allow you to make requests on behalf
of only a single store.

`ExShopify` handles this distinction using something we call "sessions". A
session contains all the information necessary to make requests to the Shopify
API as either a public app or a private app.

**Additional Reading**

* [Authentication - Public apps](https://help.shopify.com/en/api/getting-started/authentication/public-authentication)
* [Authentication - Private apps](https://help.shopify.com/en/api/getting-started/authentication/private-authentication)

## Private Sessions

You can make API requests as a private app using a private session. A private
session can be created using the `Shopify.new_private_session/3` function. This
function takes shop name, api key and password as arguments.

**Example**
```elixir
session = Shopify.new_private_session("johns-apparel", "4478eb7ac138a136852babd861956c19", "3e5a6edec71eab039422c6444d02659d")
```

## Supported Endpoints
- [x] Customer
- [x] CustomerAddress
- [x] CustomerSavedSearch
- [x] OAuth
- [x] Webhook
