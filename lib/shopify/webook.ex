defmodule Shopify.Webhook do
  @moduledoc """
  [https://help.shopify.com/en/api/reference/events/webhook](https://help.shopify.com/en/api/reference/events/webhook)
  """

  @doc """
  Retrieve a count of existing webhook subscriptions.
  """
  @spec count(map) :: Shopify.Operation.t()
  def count(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "/webhooks/count.json"
    }
  end

  @doc """
  Register a webhook.
  """
  @spec create(map) :: Shopify.Operation.t()
  def create(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "/webhooks.json"
    }
  end

  @doc """
  Delete a webhook.
  """
  @spec delete(binary) :: Shopify.Operation.t()
  def delete(webhook_id) do
    %Shopify.Operation{
      http_method: :delete,
      path: "/webhooks/#{webhook_id}.json"
    }
  end

  @doc """
  Retrieve a single registered webhook.
  """
  @spec get(binary) :: Shopify.Operation.t()
  def get(webhook_id) do
    %Shopify.Operation{
      http_method: :get,
      path: "/webhooks/#{webhook_id}.json"
    }
  end

  @doc """
  Retrieve a list of registered webhooks.
  """
  @spec list(map) :: Shopify.Operation.t()
  def list(params \\ %{}) do
    %Shopify.Operation{
      http_method: :get,
      params: params,
      path: "/webhooks.json"
    }
  end

  @doc """
  Update a registered webhook.
  """
  @spec update(binary, map) :: Shopify.Operation.t()
  def update(webhook_id, params) do
    %Shopify.Operation{
      http_method: :put,
      params: params,
      path: "/webhooks/#{webhook_id}.json"
    }
  end
end
