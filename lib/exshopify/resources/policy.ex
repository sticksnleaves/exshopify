defmodule ExShopify.Policy do
  @moduledoc """
  Setting that a merchant has configured for their store.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type policy_plural :: {:ok, [%ExShopify.Policy{}], %ExShopify.Meta{}}

  @plural "policies"

  defstruct [:body, :created_at, :title, :updated_at, :url]

  @doc """
  Receive a list of all policies.

  ## Examples

      iex> ExShopify.Policy.list(session)
      {:ok, policies, meta}
  """
  @spec list(%ExShopify.Session{}) :: policy_plural | ExShopify.Resource.error
  def list(session) do
    request(:get, "/policies.json", %{}, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
