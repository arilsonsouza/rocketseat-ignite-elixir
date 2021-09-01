defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  describe "build/5" do
    test "should return an user when passes valid params" do
      response = User.build("Joe", "joe@email.com", "1234", 25, "Las Vegas")

      expected =
        {:ok,
         %User{name: "Joe", email: "joe@email.com", tax_id: "1234", age: 25, address: "Las Vegas"}}

      assert response == expected
    end

    test "should return an error when passes invalid params" do
      response = User.build("Joe", "joe@email.com", "1234", 17, "Las Vegas")

      expected = {:error, :invalid_parameters}
      assert response == expected
    end
  end
end
