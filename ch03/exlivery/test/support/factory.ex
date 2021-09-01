defmodule Exlivery.Factory do
  use ExMachina
  alias Exlivery.Users.User
  alias Exlivery.Orders.Item

  def user_factory() do
    %User{
      name: "Joe",
      email: "joe@email.com",
      tax_id: "1234",
      age: 25,
      address: "Las Vegas"
    }
  end

  def item_factory() do
    %Item{
      description: "Pizza",
      category: :pizza,
      unity_price: Decimal.new("29.99"),
      quantity: 2
    }
  end
end
