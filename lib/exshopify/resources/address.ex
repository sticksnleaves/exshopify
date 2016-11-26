defmodule ExShopify.Address do
  @moduledoc """
  The mailing address associated with the payment method or where the order will
  be shipped.
  """

  defstruct [:address1, :address2, :city, :company, :country, :country_code,
             :first_name, :last_name, :latitude, :longitude, :name, :phone,
             :province, :province_code, :zip]
end
