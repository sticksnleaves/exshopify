defmodule Shopify.Response do
  @type t :: %__MODULE__{
    body: map,
    headers: [{binary, binary}],
    status_code: pos_integer
  }

  defstruct body: %{},
            headers: nil,
            status_code: nil

  def get_header(response, name) do
    header = Enum.find(response.headers, fn({k, _v}) -> k == name end)

    case header do
      {_k, v} ->
        v
      _otherwise ->
        nil
    end
  end
end
