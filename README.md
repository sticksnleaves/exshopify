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

## Supported Endpoints
- [x] Customer
- [x] CustomerAddress
- [x] CustomerSavedSearch
- [x] OAuth
- [x] Webhook
