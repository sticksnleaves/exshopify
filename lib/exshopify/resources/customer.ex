defmodule ExShopify.Customer do
  @moduledoc """
  Information about the customer.
  """

  defstruct [:accepts_marketing, :created_at, :email, :first_name, :id,
             :last_name, :note, :orders_count, :state, :total_spent, :updated_at,
             :tags]
end
