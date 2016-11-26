defmodule ExShopify.ClientDetails do
  @moduledoc """
  Information about the client.
  """

  defstruct [:accept_language, :browser_height, :browser_ip, :browser_width,
             :session_hash, :user_agent]
end
