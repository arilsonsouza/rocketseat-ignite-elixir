defmodule Exlivery.Factory do
  use ExMachina
  alias Exlivery.Users.User

  def user_factory() do
    %User{
      name: "Joe",
      email: "joe@email.com",
      tax_id: "1234",
      age: 25,
      address: "Las Vegas"
    }
  end
end
