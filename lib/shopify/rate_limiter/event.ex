defmodule Shopify.RateLimiter.Event do
  @type t :: %__MODULE__{
               attempts: pos_integer,
               opts: list,
               owner: pid,
               producer: pid,
               request: Shopify.Request.t()
             }

  defstruct attempts: 0,
            opts: [],
            owner: nil,
            producer: nil,
            request: nil
end
