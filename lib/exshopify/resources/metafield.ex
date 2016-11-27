defmodule ExShopify.Metafield do
  @moduledoc """
  Additional metadata to a store's resources.
  """

  defstruct [:description, :key, :namespace, :value, :value_type]
end
