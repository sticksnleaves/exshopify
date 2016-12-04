defmodule ExShopify.GiftCard do
  @moduledoc """
  Alternative payment method, and has a code which is entered during checkout.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type gift_card_plural :: {:ok, [%ExShopify.GiftCard{}], %ExShopify.Meta{}}
  @type gift_card_singular :: {:ok, %ExShopify.GiftCard{}, %ExShopify.Meta{}}

  @plural "gift_cards"
  @singular "gift_card"

  defstruct [:api_client_id, :balance, :currency, :code, :created_at,
             :disabled_at, :expires_on, :id, :last_characters, :line_item_id,
             :masked_code, :note, :order_id, :template_suffix, :updated_at,
             :user_id]

  @doc """
  Receive a count of all gift cards.

  ## Examples

      iex> ExShopify.GiftCard.count(session)
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, map) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, params) do
    request(:get, "/gift_cards/count.json", params, session)
    |> decode(decoder("count"))
  end

  @spec count(%ExShopify.Session{}) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session) do
    count(session, %{})
  end

  @doc """
  Create a new gift card.

  ## Examples

  ### Create a new gift card with a custom code

      iex> params = %ExShopify.GiftCard{
      ...>   note: "This is a note",
      ...>   initial_value: 100.0,
      ...>   code: "ABCD EFGH IJKL MNOP",
      ...>   template_suffix: "gift_cards.birthday.liquid"
      ...> }

      iex> ExShopify.GiftCard.create(session, params)
      {:ok, gift_card, meta}

  ### Create a new gift card with an automatically generated code

      iex> params = %ExShopify.GiftCard{
      ...>   initial_value: 25.0,
      ...> }

      iex> ExShopify.GiftCard.create(session, params)
      {:ok, gift_card, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: gift_card_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/gift_cards.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Disable a gift card.

  ## Examples

      iex> ExShopify.GiftCard.disable(session, 48394658)
      {:ok, gift_card, meta}
  """
  @spec disable(%ExShopify.Session{}, integer | String.t) :: gift_card_singular | ExShopify.Resource.error
  def disable(session, id) do
    request(:post, "/gift_cards/#{id}/disable.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Receive a single gift card.

  ## Examples

      iex> ExShopify.GiftCard.find(session, 48394658)
      {:ok, gift_card, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t) :: gift_card_singular | ExShopify.Resource.error
  def find(session, id) do
    request(:get, "/gift_cards/#{id}.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Receive a list of all gift cards.

  ## Examples

      iex> ExShopify.GiftCard.list(session)
      {:ok, gift_cards, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: gift_card_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/gift_cards.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: gift_card_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Search for gift cards.

  ## Examples

      iex> ExShopify.GiftCard.search(session, %{query: "Bob"})
      {:ok, gift_cards, meta}
  """
  @spec search(%ExShopify.Session{}, map) :: gift_card_plural | ExShopify.Resource.error
  def search(session, params) do
    request(:get, "/gift_cards/search.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @doc """
  Modify an existing gift card.

  ## Examples

      iex> params = %{note: "Updating with a new note"}

      iex> ExShopify.GiftCard.update(session, 48394658, params)
      {:ok, gift_card, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: gift_card_singular | ExShopify.Resource.error
  def update(session, id, params) do
    request(:put, "/gift_cards/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
