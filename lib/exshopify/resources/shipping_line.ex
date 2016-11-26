defmodule ExShopify.ShippingLine do
  @moduledoc """
  Details the shipping methods used.
  """

  defstruct [:carrier_identifier, :code, :price,
             :requested_fulfillment_service_id, :source, :tax_lines, :title]

  @doc false
  def response_mapping do
    %ExShopify.ShippingLine{
      tax_lines: [%ExShopify.TaxLine{}]
    }
  end
end
