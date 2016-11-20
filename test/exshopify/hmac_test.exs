defmodule ExShopify.HMAC.Test do
  use ExUnit.Case, async: true

  test "should return {:ok, digest} if HMAC is valid" do
    hmac          = "4712bf92ffc2917d15a2f5a273e39f0116667419aa4b6ac0b3baaf26fa3c4d20"
    message       = "code=0907a61c0c8d55e99db179b68161bc00&shop=some-shop.myshopify.com&timestamp=1337178173"
    shared_secret = "hush"

    assert ExShopify.HMAC.verify(hmac, message, shared_secret) == {:ok, hmac}
  end

  test "should return {:error, digest} if HMAC is invalid" do
    hmac          = "4712bf92ffc2917d15a2f5a273e39f0116667419aa4b6ac0b3baaf26fa3c4d20"
    message       = "code=0907a61c0c8d55e99db179b68161bc00&shop=some-shop.myshopify.com&timestamp=1337178173"
    shared_secret = "nope"
    digest        = "f975cd1feb7dd9dd88b90cc002d1a3c17ab3644d7eddac058d36f11dfdb7000f"

    assert ExShopify.HMAC.verify(hmac, message, shared_secret) == {:error, digest}
  end
end
