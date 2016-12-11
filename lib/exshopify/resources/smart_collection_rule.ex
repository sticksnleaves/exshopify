defmodule ExShopify.SmartCollectionRule do
  @moduledoc """
  Defines what products go into the smart collection.
  """

  defstruct [:column, :condition, :relation]
end
