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

`ExShopify` works with `hackney` (HTTP client) and `jason` (JSON codec) out of
the box. You may supply your own HTTP client or JSON codec.

## Supported Endpoints
[x] - Customer
[x] - CustomerAddress
[x] - CustomerSavedSearch
[x] - OAuth
[x] - Webhook
