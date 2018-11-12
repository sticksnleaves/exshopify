defmodule ShopifyTest do
  use ExUnit.Case, async: true

  test "get_slug_from_shop/1" do
    assert "johns-apparel" = Shopify.get_slug_from_shop("johns-apparel.myshopify.com")
  end
end
