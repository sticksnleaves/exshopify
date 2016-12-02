defmodule ExShopify.CarrierService do
  @moduledoc """
  Provide real-time shipping rates to Shopify.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type carrier_service_plural :: {:ok, [%ExShopify.CarrierService{}], %ExShopify.Meta{}}
  @type carrier_service_singular :: {:ok, %ExShopify.CarrierService{}, %ExShopify.Meta{}}

  @plural "carrier_services"
  @singular "carrier_service"

  defstruct [:active, :carrier_service_type, :format, :id, :name,
             :service_discovery]

  @doc """
  Create a carrier service.

  ## Examples

      iex> params = %ExShopify.CarrierService{
      ...>   name: "Shipping Rate Provider",
      ...>   callback_url: "http://shippingrateprovider.com",
      ...>   service_discovery: true
      ...> }

      iex> ExShopify.CarrierService.create(session, params)
      {:ok, carrier_service, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: carrier_service_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/carrier_services.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Destroy a carrier service.

  ## Examples

      iex> ExShopify.CarrierService.delete(session, 1006327370)
      {:ok, meta}
  """
  @spec create(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.only_meta | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/carrier_services/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Get a single carrier service.

  ## Examples

      iex> ExShopify.CarrierService.find(session, 1006327375)
      {:ok, carrier_service, meta}
  """
  def find(session, id) do
    request(:get, "/carrier_services/#{id}.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  List carrier services.

  ## Examples

      iex> ExShopify.CarrierService.list(session)
      {:ok, carrier_services, meta}
  """
  def list(session) do
    request(:get, "/carrier_services.json", %{}, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @doc """
  Update a carrier service.

  ## Examples
      iex> params = %ExShopify.CarrierService{
      ...>   name: "Some new name",
      ...>   active: false,
      ...>   service_discovery: true,
      ...>   carrier_service_type: "api",
      ...>   format: "json"
      ...> }

      iex> ExShopify.CarrierService.update(session, 1006327369, params)
      {:ok, carrier_service, meta}
  """
  def update(session, id, params) do
    request(:put, "/carrier_services/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
