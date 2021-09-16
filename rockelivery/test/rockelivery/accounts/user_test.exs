defmodule Rockelivery.Accounts.UserTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.Accounts.User

  setup %{} do
    {:ok, user_attrs: build(:user_attrs)}
  end

  describe "registration_changeset/2" do
    test "should return a valid changeset when all attrs are valid", %{user_attrs: user_attrs} do
      response = User.registration_changeset(%User{}, user_attrs)

      assert %Changeset{changes: %{name: "Joe"}, valid?: true} = response
    end

    test "should return an invalid changeset when some attrs are invalid", %{
      user_attrs: user_attrs
    } do
      response =
        User.registration_changeset(%User{}, %{
          user_attrs
          | "tax_id" => "12345678",
            "password" => "123"
        })

      expected = %{
        password: ["should be at least 6 character(s)"],
        tax_id: ["should be 11 character(s)"]
      }

      assert errors_on(response) == expected
    end
  end

  describe "update_changeset/2" do
    test "should update a changeset when all attrs are valid", %{user_attrs: user_attrs} do
      response =
        User.update_changeset(%User{email: "joe@email.com", name: "Joe"}, %{
          user_attrs
          | "email" => "mary@email.com",
            "name" => "Mary",
            "tax_id" => "12345678934"
        })

      assert %Changeset{
               changes: %{email: "mary@email.com", name: "Mary", tax_id: "12345678934"},
               valid?: true
             } = response
    end

    test "should return an invalid changeset when some attrs are invalid", %{
      user_attrs: user_attrs
    } do
      response =
        User.update_changeset(%User{email: "joe@email.com", name: "Joe"}, %{
          user_attrs
          | "tax_id" => "12345678"
        })

      expected = %{tax_id: ["should be 11 character(s)"]}
      assert errors_on(response) == expected
    end
  end
end
