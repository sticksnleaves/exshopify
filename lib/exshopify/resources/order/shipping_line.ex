defmodule ExShopify.Order.ShippingLine do
  @moduledoc """
  Details the shipping methods used.
  """

  defstruct [:carrier_identifier, :code, :price,
             :requested_fulfillment_service_id, :source, :tax_lines, :title]

  @doc false
  def response_mapping do
    %ExShopify.Order.ShippingLine{
      tax_lines: [%ExShopify.Order.TaxLine{}]
    }
  end
end
