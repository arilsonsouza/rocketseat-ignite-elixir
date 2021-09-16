defmodule Exmeal.Users.UserTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Ecto.Changeset
  alias Exmeal.Users.User

  describe "changeset/2" do
    test "should return a valid changeset when all attrs are valid" do
      response = User.changeset(%User{}, build(:user_attrs))

      assert %Changeset{
               changes: %{email: "jhon4@email.com", name: "Jhon", tax_id: "00000000002"},
               valid?: true
             } = response
    end

    test "should return an invalid changeset when some attrs are invalid" do
      response = User.changeset(%User{}, %{})

      expected = %{
        email: ["can't be blank"],
        name: ["can't be blank"],
        tax_id: ["can't be blank"]
      }

      assert errors_on(response) == expected
    end
  end
end
