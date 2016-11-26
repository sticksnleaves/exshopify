defmodule ExShopify.Order.TaxLine do
  @moduledoc """
  Details the total taxes applicable to the order.
  """

  defstruct [:price, :rate, :title]
end
