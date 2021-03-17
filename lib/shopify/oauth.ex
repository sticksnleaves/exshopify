defmodule Shopify.OAuth do
  @moduledoc """
  [https://help.shopify.com/en/api/getting-started/authentication/oauth](https://help.shopify.com/en/api/getting-started/authentication/oauth)
  """

  @doc """
  Request an access token.
  """
  @spec get_access_token(map) :: Shopify.Operation.t()
  def get_access_token(params) do
    %Shopify.Operation{
      http_method: :post,
      params: params,
      path: "/oauth/access_token"
    }
  end

  @doc """
  Revoke access from the current access token.
  """
  @spec revoke_access_token :: Shopify.Operation.t()
  def revoke_access_token do
    %Shopify.Operation{
      http_method: :delete,
      path: "/api_permissions/current.json"
    }
  end
end
