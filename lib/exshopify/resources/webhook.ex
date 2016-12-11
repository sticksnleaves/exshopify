defmodule ExShopify.Webhook do
  @moduledoc """
  An HTTP request to an app after a specific event happens on a shop.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type webhook_plural :: {:ok, [%ExShopify.Webhook{}], %ExShopify.Meta{}}
  @type webhook_singular :: {:ok, %ExShopify.Webhook{}, %ExShopify.Meta{}}

  @plural "webhooks"
  @singular "webhook"

  defstruct [:address, :created_at, :fields, :format, :id,
             :metafield_namespaces, :topic, :updated_at]

  @doc """
  Receive a count of all webhooks.

  ## Examples

      iex> ExShopify.Webhook.count(session)
      {:ok, webhook, meta}
  """
  @spec count(%ExShopify.Session{}, map) :: webhook_singular | ExShopify.Resource.error
  def count(session, params) do
    request(:get, "/webhooks/count.json", params, session)
    |> decode(decoder("count"))
  end

  def count(session) do
    count(session, %{})
  end

  @doc """
  Create a new webhook.

  ## Examples

      iex> params = %{
      ...>   topic: "orders/create",
      ...>   address: "http://whatever.hostname.com/",
      ...>   format: "json"
      ...> }

      iex> ExShopify.Webhook.create(session, params)
      {:ok, webhook, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: webhook_singular | ExShopify.Resource.error
  def create(session, params) do
    request(:post, "/webhooks.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Remove a webhook from the database.

  ## Examples

      iex> ExShopify.Webhook.delete(session, 4759306)
      {:ok, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: ExShopify.Resource.meta_only | ExShopify.Resource.error
  def delete(session, id) do
    request(:delete, "/webhooks/#{id}.json", %{}, session)
    |> decode(nil)
  end

  @doc """
  Receive a single webhooks.

  ## Examples

      iex> ExShopify.Webhook.find(session, 4759306)
      {:ok, webhook, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: webhook_singular | ExShopify.Resource.error
  def find(session, id, params) do
    request(:get, "/webhooks/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: webhook_singular | ExShopify.Resource.error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  Receive a list of all webhooks.

  ## Examples

      iex> ExShopify.Webhook.list(session)
      {:ok, webhooks, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: webhook_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/webhooks.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: webhook_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Modify an existing namespace.

  ## Examples

      iex> params = %{
      ...>   address: "http://somewhere-else.com/"
      ...> }

      iex> ExShopify.Webhook.update(session, 4759306, params)
      {:ok, webhook, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: webhook_singular | ExShopify.Resource.error
  def update(session, id, params) do
    request(:put, "/webhooks/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
