defmodule Exlivery.Orders.Item do
  @cateories [:pizza, :hamburguer, :japanese_food]

  @keys [:description, :category, :unity_price, :quantity]
  @enforce_keys @keys

  defstruct @keys

  def build(description, category, unity_price, quantity)
      when category in @cateories and quantity > 0 do
    {:ok,
     %__MODULE__{
       description: description,
       category: category,
       unity_price: unity_price,
       quantity: quantity
     }}
  end

  def build(_description, _category, _unity_price, _quantity), do: {:error, :invalid_parameter}
end
