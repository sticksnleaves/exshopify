defmodule Shopify.HMACTest do
  use ExUnit.Case, async: true

  test "verify/2" do
    query = "code=0907a61c0c8d55e99db179b68161bc00&hmac=4712bf92ffc2917d15a2f5a273e39f0116667419aa4b6ac0b3baaf26fa3c4d20&shop=some-shop.myshopify.com&timestamp=1337178173"
    shared_secret = "hush"

    hmac = "4712bf92ffc2917d15a2f5a273e39f0116667419aa4b6ac0b3baaf26fa3c4d20"

    assert {:ok, ^hmac} = Shopify.HMAC.verify(query, shared_secret)
  end

  test "verify/3" do
    hmac = "4712bf92ffc2917d15a2f5a273e39f0116667419aa4b6ac0b3baaf26fa3c4d20"
    message = "code=0907a61c0c8d55e99db179b68161bc00&shop=some-shop.myshopify.com&timestamp=1337178173"
    shared_secret = "hush"

    assert {:ok, ^hmac} = Shopify.HMAC.verify(hmac, message, shared_secret)
  end
end
