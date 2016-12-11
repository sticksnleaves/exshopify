defmodule ExShopify.User do
  @moduledoc """
  Administrative user for a shop.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type user_plural :: {:ok, [%ExShopify.User{}], %ExShopify.Meta{}}
  @type user_singular :: {:ok, %ExShopify.User{}, %ExShopify.Meta{}}

  @plural "users"
  @singular "user"

  defstruct [:account_owner, :bio, :email, :first_name, :id, :im, :last_name,
             :permissions, :phone, :pin, :receive_announcements, :screen_name,
             :url, :user_type]

  @doc """
  Get the current logged-in user.

  ## Examples

      iex> ExShopify.User.current(session)
      {:ok, user, meta}
  """
  @spec current(%ExShopify.Session{}) :: user_singular | ExShopify.Resource.error
  def current(session) do
    request(:get, "/users/current.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Receive a single user.

  ## Examples

      iex> ExShopify.User.find(session, 799407056)
      {:ok, user, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t) :: user_singular | ExShopify.Resource.error
  def find(session, id) do
    request(:get, "/users/#{id}.json", %{}, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @doc """
  Receive a list of all users.

  ## Examples

      iex> ExShopify.User.list(session)
      {:ok, users, meta}
  """
  @spec list(%ExShopify.Session{}) :: user_plural | ExShopify.Resource.error
  def list(session) do
    request(:get, "/users.json", %{}, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
