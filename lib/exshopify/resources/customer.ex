defmodule ExShopify.Customer do
  defstruct [:accepts_marketing, :created_at, :email, :first_name, :id,
             :last_name, :note, :order_count, :state, :total_spent, :updated_at,
             :tags]
end
