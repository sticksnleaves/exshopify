defmodule ExShopify.Order.Address do
  @moduledoc """
  The mailing address associated with the payment method. This address is an
  optional field that will not be available on orders that do not require one.
  """

  defstruct [:address1, :address2, :city, :company, :country, :country_code,
             :first_name, :last_name, :latitude, :longitude, :name, :phone,
             :province, :province_code, :zip]
end
