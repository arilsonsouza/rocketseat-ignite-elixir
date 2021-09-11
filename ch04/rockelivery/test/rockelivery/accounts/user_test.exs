defmodule Rockelivery.Accounts.UserTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.Changeset
  alias Rockelivery.Accounts.User

  setup %{} do
    user_attrs = %{
      email: "joe@email.com",
      name: "Joe",
      tax_id: "12345678912",
      password: "123456",
      birth_date: ~D[1996-03-01],
      cep: "44905000",
      address: "Mocca"
    }

    {:ok, user_attrs: user_attrs}
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
        User.registration_changeset(%User{}, %{user_attrs | tax_id: "12345678", password: "123"})

      assert %Changeset{valid?: false} = response
    end
  end

  describe "update_changeset/2" do
    test "should update a changeset when all attrs are valid", %{user_attrs: user_attrs} do
      response =
        User.update_changeset(%User{email: "joe@email.com", name: "Joe"}, %{
          user_attrs
          | email: "mary@email.com",
            name: "Mary",
            tax_id: "12345678934"
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
          | tax_id: "12345678"
        })

      assert %Changeset{valid?: false} = response
    end
  end
end