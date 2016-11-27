defmodule ExShopify.ApplicationCredit do
  @moduledoc """
  A credit for a shop.
  """

  use ExShopify.Resource
  import ExShopify.API

  @type application_credit_resource :: {:ok, %ExShopify.ApplicationCredit{}, %ExShopify.Meta{}}

  @plural "application_credits"
  @singular "application_credit"

  defstruct [:amount, :description, :id, :test]

  @doc """
  Create a new credit.
  """
  @spec create(%ExShopify.Session{}, map) :: application_credit_resource | ExShopify.Resource.error
  def create(session \\ nil, params) do
    request(:post, "/application_credits.json", params, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Retrieve a single application credit.
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: application_credit_resource | ExShopify.Resource.error
  def find(session \\ nil, id, params \\ %{}) do
    request(:get, "/application_credits/#{id}.json", params, session)
    |> decode(&decode_singular/1)
  end

  @doc """
  All past and present application credits.
  """
  @spec list(%ExShopify.Session{}, map) :: application_credit_resource | ExShopify.Resource.error
  def list(session \\ nil, params \\ %{}) do
    request(:get, "/application_credits.json", params, session)
    |> decode(&decode_plural/1)
  end

  @doc false
  def response_mapping do
    %ExShopify.ApplicationCredit{}
  end
end
