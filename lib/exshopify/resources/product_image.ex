defmodule ExShopify.ProductImage do
  @moduledoc """
  Images of a product.
  """

  defstruct [:created_at, :id, :position, :product_id, :variant_ids, :src,
             :updated_at]

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
