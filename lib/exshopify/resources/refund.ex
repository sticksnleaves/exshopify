defmodule ExShopify.Refund do
  @moduledoc """
  Record of the money returned to the customer, and/or the return of any items
  on an order which may or may not have been restocked.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type refund_plural :: {:ok, [%ExShopify.Refund{}], %ExShopify.Meta{}}
  @type refund_singular :: {:ok, %ExShopify.Refund{}, %ExShopify.Meta{}}

  @plural "refunds"
  @singular "refund"

  defstruct [:created_at, :id, :note, :refund_line_items, :restock,
             :transactions, :user_id]

  @doc """
  Calculate a refund.

  ## Examples

  ### Calculate a refund for a partial amount of shipping

      iex> params = %{
      ...>   shipping: %{
      ...>     amount: 2.0
      ...>   }
      ...> }

      iex> ExShopify.Refund.calculate(session, 450789469, params)
      {:ok, refund, meta}

  ### Calculate a refund for a line item and shipping

      iex> params = %{
      ...>   shipping: %{
      ...>     full_refund: true
      ...>   },
      ...>   refund_line_items: [
      ...>     %{
      ...>       line_item_id: 518995019,
      ...>       quantity: 1
      ...>     }
      ...>   ]
      ...> }

      iex> ExShopify.Refund.calculate(session, 450789469, params)
      {:ok, refund, meta}
  """
  @spec calculate(%ExShopify.Session{}, integer | String.t, map) :: refund_singular
  def calculate(session, order_id, params) do
    request(:post, "/orders/#{order_id}/refunds/calculate.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Create a refund.

  ## Examples

  ### Create a new refund for an order

      iex> params = %{
      ...>   restock: true,
      ...>   notify: true,
      ...>   note: "wrong size",
      ...>   shipping: %{
      ...>     full_refund: true
      ...>   },
      ...>   refund_line_items: [
      ...>     %{
      ...>       line_item_id: 518995019,
      ...>       quantity: 1
      ...>     }
      ...>   ],
      ...>   transactions [
      ...>     %{
      ...>       parent_id: 801038806,
      ...>       amount: 199.65,
      ...>       kind: refund,
      ...>       gateway: "bogus"
      ...>     }
      ...>   ]
      ...> }

      iex> ExShopify.Refund.create(session, 450789469, params)
      {:ok, refund, meta}

  ### Refunding a specific amount of shipping

      iex> params = %{
      ...>   shipping: %{
      ...>     amount: 5.0
      ...>   },
      ...>   transactions [
      ...>     %{
      ...>       parent_id: 801038806,
      ...>       amount: 5.0,
      ...>       kind: refund,
      ...>       gateway: "bogus"
      ...>     }
      ...>   ]
      ...> }

      iex> ExShopify.Refund.create(session, 450789469, params)
      {:ok, refund, meta}
  """
  @spec create(%ExShopify.Session{}, integer | String.t, map) :: refund_singular | ExShopify.Resource.error
  def create(session, order_id, params) do
    request(:post, "/orders/#{order_id}/refunds.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Receive a single refund.

  ## Examples

      iex> ExShopify.Refund.find(session, 509562969, 450789469)
      {:ok, refund, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t, map) :: refund_singular | ExShopify.Resource.error
  def find(session, id, order_id, params) do
    request(:get, "/orders/#{order_id}/refunds/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t, integer | String.t) :: refund_singular | ExShopify.Resource.error
  def find(session, id, order_id) do
    find(session, id, order_id, %{})
  end

  @doc """
  Retrieve a list of refunds for an order.

  ## Examples

      iex> ExShopify.Refund.list(session)
      {:ok, refunds, meta}
  """
  @spec list(%ExShopify.Session{}, integer | String.t, map) :: refund_plural | ExShopify.Resource.error
  def list(session, order_id, params) do
    request(:get, "/orders/#{order_id}/refunds.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}, integer | String.t) :: refund_plural | ExShopify.Resource.error
  def list(session, order_id) do
    list(session, order_id, %{})
  end

  @doc false
  def response_mapping do
    %ExShopify.Refund{
      refund_line_items: [ExShopify.RefundLineItem.response_mapping],
      transactions: [ExShopify.Transaction.response_mapping]
    }
  end
end
