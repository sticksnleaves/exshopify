defmodule ExShopify.Discount do
  @moduledoc """
  Applicable discounts that can be applied to the order.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type discount_plural :: {:ok, [%ExShopify.Discount{}], %ExShopify.Meta{}}
  @type discount_singular :: {:ok, %ExShopify.Discount{}, %ExShopify.Meta{}}

  @plural "discounts"
  @singular "discount"

  defstruct [:applies_once, :applies_once_per_customer, :applies_to_id,
             :applies_to_resource, :code, :discount_type, :ends_at, :id,
             :minimum_order_amount, :starts_at, :status, :times_used, :value,
             :usage_limit]

  @doc """
  Create a discount.

  ## Examples

  ### Create a discount code "balderdash" that gives the buyer 15% off

      iex> params = %ExShopify.Discount{
      ...>   discount_type: "percentage",
      ...>   value: "15.0",
      ...>   code: "balderdash"
      ...> }

      iex> ExShopify.Discount.create(session, params)
      {:ok, discount, meta}

  ### Create a discount code "fortunamajor" that gives the buyer $10 off if their order total exceeds $40

      iex> params = %ExShopify.Discount{
      ...>   discount_type: "fixed_amount",
      ...>   value: "10.00",
      ...>   code: "fortunamajor",
      ...>   minimum_order_amount: "40.00"
      ...> }

      iex> ExShopify.Discount.create(session, params)
      {:ok, discount, meta}


  ### Create a free shipping discount code "quidagis?" that can be used up to 20 times by shoppers during a specific time period

      iex> params = %ExShopify.Discount{
      ...>   discount_type: "shipping",
      ...>   code: "quidagis",
      ...>   starts_at: "2015-08-23T00:00:00-04:00",
      ...>   ends_at: "2015-08-27T23:59:59-04:00",
      ...>   usage_limit: 20
      ...> }

      iex> ExShopify.Discount.create(session, params)
      {:ok, discount, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: discount_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/discounts.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Delete a discount.

      iex> ExShopify.Discount.delete(session, 680866)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.only_meta | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/discounts/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Disable a discount.

  ## Examples

      iex> ExShopify.Discount.disable(session, 680866)
      {:ok, meta}
  """
  @spec disable(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.only_meta | ExShopify.Resource.error
  def disable(session, id) do
    request(:post, "/discounts/#{id}/disable.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Enable a discount.

  ## Examples

      iex> ExShopify.Discount.enable(session, 949676421)
      {:ok, discount, meta}
  """
  @spec enable(%ExShopify.Session{}, integer | String.t) :: discount_singular | ExShopify.Resource.error
  def enable(session, id) do
    request(:post, "/discounts/#{id}/enable.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Retrieve a discount.

  ## Examples

      iex> ExShopify.Discount.find(session, 680866)
      {:ok, discount, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t) :: discount_singular | ExShopify.Resource.error
  def find(session, id) do
    request(:get, "/discounts/#{id}.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  List all discounts.

  ## Examples

      iex> ExShopify.Discount.list(session)
      {:ok, discounts, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: discount_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/discounts.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: discount_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
