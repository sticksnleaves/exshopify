defmodule ExShopify.Province do
  @moduledoc """
  The sub-regions of a country.
  """

  defstruct [:code, :country_id, :id, :name, :tax, :tax_name, :tax_type,
             :tax_percentage]
end
