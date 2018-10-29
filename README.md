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

## Making Requests

Making requests to the API is done using the `Shopify.request/3` function. You
pass an operation, a session (more on sessions below) and an optional
config as arguments.

An operation is a struct that describes the HTTP request to be executed. You can
create an operation manually but typically you would use one of the resource
modules to create one for you.

**Example**

```elixir
Shopify.Customer.list() |> Shopify.request(session)
```

You can see which resource modules have been implemented under
[Supported Endpoints](#supported-endpoints). If we have not added support for an
endpoint you need you can still make a request by constructing an operation
manually.

**Example**

```elixir
%Shopify.Operation{http_method: :get, path: "admin/customers.json"} |> Shopify.request(session)
```

Opening issues and PR's for unsupported endpoints is always appreciated.

## Configuration

When making a request you can pass an optional config as the third argument.

**Example**

```elixir
config = %Shopify.Config{http_client: {MyHttpClient, []}}

Shopify.Customer.list() |> Shopify.request(session, config)
```

### Configuration Options

* `:host` - HTTP host to make requests to. Defaults to `myshopify.com`.
* `:http_client` - the HTTP client used to make requests. Takes a module that
                   implements the `Shopify.Client` behaviour. Defaults to
                   `Shopify.Client.Hackney`.
* `:http_client_opts` - options to be passed to the configured `:http_client`
* `:json_codec` - the JSON encoder and decoder. Defaults to `Jason`.
* `:port` - the HTTP port used when making requests
* `:scheme` - the HTTP scheme used when making requests. Defaults to `https`.

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
* [Authentication - OAuth](https://help.shopify.com/en/api/getting-started/authentication/oauth)

## Private Sessions

You can make API requests as a private app using a private session. A private
session can be created using the `Shopify.new_private_session/3` function. This
function takes shop name, api key and password as arguments.

**Example**

```elixir
session = Shopify.new_private_session("johns-apparel", "4478eb7ac138a136852babd861956c19", "3e5a6edec71eab039422c6444d02659d")
```

## Public Sessions

You can make API requests as a public app using a public session. Public
sessions are also used when obtaining an OAuth access token. You can create a
public sessions using the `Shopify.new_public_sessions/2` function. This
function takes a shop name and an optional access token as arguments.

**Example**

```elixir
session = Shopify.new_public_session("johns-apparel", "f85632530bf277ec9ac6f649fc327f17")
```

## OAuth

For a detailed explanation of the Shopify OAuth authorization process please
see the [Shopify OAuth documentation](https://help.shopify.com/en/api/getting-started/authentication/oauth).

You can obtain an access token using the `Shopify.OAuth.get_access_token/1`
function.

**Example**

```elixir
session = Shopify.new_public_session("johns-apparel")

%{client_id: "43f41262ce65cd5d4e8a4081649208e3", client_secret: "2240ab28b61f42e6c8bfc0adcbfc5ac2", code: "18djf91ufv0vkr938z7b69v810v710v7"}
|> Shopify.OAuth.get_access_token()
|> Shopify.request(session)
```

## Rate Limiting

You can throttle your requests to the Shopify REST API by using the
`Shopify.Client.RateLimit` HTTP client.  This client will throttle the requests
it sends to Shopify in order to stay below the maximum call limit.

`Shopify.Client.RateLimit` acts as a pass through. It only implements the
rate limiting logic and hands off the responsibility of making an actual HTTP
request to the HTTP client of your choice.

To use `Shopify.Client.RateLimit` you will need to add `gen_stage` as a
dependency. You will also need to add `Shopify.RateLimiter` to your supervision
tree.

When making API requests you will need to specify `Shopify.Client.RateLimit`
in the request config as `:http_client`. You will then need to specify the
pass through HTTP client in the `:http_client_opts` config option.

**Example**

```elixir
config =
  %Shopify.Config{
    http_client: Shopify.Client.RateLimit,
    http_client_opts: [
      http_client: Shopify.Client.Hackney,
      http_client_opts: [] # optional
    ]
  }

Shopify.Product.list() |> Shopify.request(session, config)
```

## Supported Endpoints

* Shopify Payments
  - [ ] Balance
  - [ ] Payouts
  - [ ] Transactions
* Access
  - [ ] AccessScope
  - [ ] StorefrontAccessToken
* Analytics
  - [ ] Report
* Billing
  - [ ] ApplicationCharge
  - [ ] ApplicationCredit
  - [ ] RecurringApplicationCharge
  - [ ] UsageCharge
* Customers
  - [x] Customer
  - [x] CustomerAddress
  - [x] CustomerSavedSearch
* Discounts
  - [ ] DiscountCode
  - [ ] PriceRule
* Events
  - [ ] Event
  - [x] Webhook
* Inventory
  - [ ] InventoryItem
  - [ ] InventoryLevel
  - [ ] Location
- [ ] MarketingEvent
- [ ] Metafield
* Online Store
  - [ ] Asset
  - [ ] Blog
  - [ ] BlogArticle
  - [ ] Comment
  - [ ] Page
  - [ ] Redirect
  - [ ] ScriptTag
  - [ ] Theme
* Orders
  - [ ] AbandonedCheckouts
  - [ ] DraftOrder
  - [ ] Order
  - [ ] OrderRisk
  - [ ] Refund
  - [ ] Transaction
* Plus
  - [ ] GiftCard
  - [ ] Multipass
  - [ ] User
* Products
  - [ ] Collect
  - [ ] CustomCollection
  - [x] Product
  - [ ] ProductImage
  - [ ] SmartCollection
* Sales Channel
  - [ ] Checkout
  - [ ] CollectionListing
  - [ ] Payment
  - [ ] ProductListing
  - [ ] ResourceFeedback
* Shipping and Fulfillment
  - [ ] CarrierService
  - [ ] Fulfillment
  - [ ] FulfillmentEvent
  - [ ] FulfillmentService
* Store Properties
  - [ ] Country
  - [ ] Currency
  - [ ] Policy
  - [ ] Province
  - [ ] ShippingZone
  - [ ] Shop
- [ ] TenderTransaction
