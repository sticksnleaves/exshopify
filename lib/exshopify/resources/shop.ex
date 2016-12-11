defmodule ExShopify.Shop do
  @moduledoc """
  A collection of the general settings and information about the shop.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type shop_singular :: {:ok, %ExShopify.Shop{}, %ExShopify.Meta{}}

  @singular "shop"

  defstruct [:address1, :address2, :city, :country, :country_code,
             :country_name, :county_taxes, :created_at, :currency,
             :customer_email, :domain, :email, :force_ssl, :google_apps_domain,
             :google_apps_login_enabled, :has_discounts, :has_gift_cards,
             :has_storefront, :iana_timezone, :id, :latitude, :longitude,
             :money_format, :money_with_currency_format, :myshopify_domain,
             :name, :password_enabled, :phone, :plan_display_name, :plan_name,
             :primary_locale, :province, :province_code, :setup_required,
             :shop_owner, :source, :tax_shipping, :taxes_included, :timezone,
             :updated_at, :zip]

  @doc """
  Get the configuration of the shop account.

  ## Examples

      ExShopify.Shop.get(session)
      {:ok, shop, meta}
  """
  @spec get(%ExShopify.Session{}) :: shop_singular | ExShopify.Resource.error
  def get(session) do
    request(:get, "/shop.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
