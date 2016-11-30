defmodule ExShopify.CustomerAddress do
  @moduledoc """
  Represents one of the many addresses a customer may have.
  """

  defstruct [:address1, :address2, :city, :company, :country, :country_code,
             :country_name, :default, :first_name, :last_name, :name, :phone,
             :province, :province_code, :zip]
end
