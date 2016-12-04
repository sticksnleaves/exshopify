defmodule ExShopify.FulfillmentService do
  @moduledoc """
  A third party warehouse that prepares and ships orders on behalf of the store
  owner.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type fulfillment_service_plural :: {:ok, [%ExShopify.FulfillmentService{}], %ExShopify.Meta{}}
  @type fulfillment_service_singular :: {:ok, %ExShopify.FulfillmentService{}, %ExShopify.Meta{}}

  @plural "fulfillment_services"
  @singular "fulfillment_service"

  defstruct [:callback_url, :format, :handle, :inventory_management, :name,
             :provider_id, :requires_shipping_method, :tracking_support]

  @doc """
  Create a new fulfillment service.

  ## Examples

      iex> ExShopify.FulfillmentService.create(session)
      {:ok, fulfillment_service, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: fulfillment_service_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/fulfillment_services.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Delete a fulfillment service.

  ## Examples

      iex> ExShopify.FulfillmentService.delete(session, 755357713)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.meta_only | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/fulfillment_services/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Receive a single fulfillment service.

  ## Examples

      iex> ExShopify.FulfillmentService.find(session, 755357713)
      {:ok, fulfillment_service, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t) :: fulfillment_service_singular | ExShopify.Resource.error
  def find(session, id) do
    request(:get, "/fulfillment_services/#{id}.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end


  @doc """
  Receive a list of fulfillment services.

  ## Examples

      iex> ExShopify.FulfillmentService.list(session)
      {:ok, fulfillments, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: fulfillment_service_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/fulfillment_services.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: fulfillment_service_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Modify an existing fulfillment service.

  ## Examples

      iex> params = %{inventory_management: false}

      iex> ExShopify.FulfillmentService.update(session, params)
      {:ok, fulfillment_service, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: fulfillment_service_singular | ExShopify.Resource.error
  def update(session, id, params) do
    request(:put, "/fulfillment_services/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
