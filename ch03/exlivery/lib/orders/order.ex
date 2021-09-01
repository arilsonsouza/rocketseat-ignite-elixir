defmodule Exlivery.Orders.Order do
  @keys [:user_tax_id, :delivery_address, :items, :amount]
  @enforce_keys @keys

  defstruct @keys

  def build(user_tax_id, delivery_address, items, amount) do
    {:ok,
     %__MODULE__{
       user_tax_id: user_tax_id,
       delivery_address: delivery_address,
       items: items,
       amount: amount
     }}
  end
end
