defmodule ExShopify.DiscountCode do
  @moduledoc """
  Applicable discount codes that can be applied to the order.
  """

  defstruct [:amount, :code, :type]
end
