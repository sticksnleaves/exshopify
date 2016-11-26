defmodule ExShopify.ApplicationCredit do
  @moduledoc """
  A credit for a shop.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type application_credit_resource :: {:ok, %ExShopify.ApplicationCredit{}, %ExShopify.Meta{}}

  defstruct [:amount, :description, :id, :test]

  @doc """
  Create a new credit.
  """
  @spec create(%ExShopify.Session{}, map) :: application_credit_resource | ExShopify.Resource.error
  def create(session \\ nil, params) do
    request(:post, "/application_credits.json", params, session)
    |> serialize_resource(&serialize_single/1)
  end

  @doc """
  Retrieve a single application credit.
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: application_credit_resource | ExShopify.Resource.error
  def find(session \\ nil, id, params \\ %{}) do
    request(:get, "/application_credits/#{id}.json", params, session)
    |> serialize_resource(&serialize_single/1)
  end

  @doc """
  All past and present application credits.
  """
  @spec list(%ExShopify.Session{}, map) :: application_credit_resource | ExShopify.Resource.error
  def list(session \\ nil, params \\ %{}) do
    request(:get, "/application_credits.json", params, session)
    |> serialize_resource(&serialize_multi/1)
  end

  @doc false
  def response_mapping do
    %ExShopify.ApplicationCredit{}
  end

  # private

  defp serialize_single(body) do
    Poison.decode!(body, as: %{"application_credit" => response_mapping})["application_credit"]
  end

  defp serialize_multi(body) do
    Poison.decode!(body, as: %{"application_credits" => [response_mapping]})["application_credits"]
  end
end
