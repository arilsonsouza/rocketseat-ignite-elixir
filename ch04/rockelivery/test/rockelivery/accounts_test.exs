defmodule Rockelivery.AccountsTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.Error
  alias Rockelivery.Accounts
  alias Rockelivery.Accounts.User

  describe "register_user/1" do
    test "should return a user when all attrs are valid" do
      attrs = build(:user_attrs)

      response = Accounts.register_user(attrs)

      assert {:ok, %User{email: "joe@email.com", name: "Joe", tax_id: "12345678912"}} = response
    end

    test "should return an error when there are invalid attrs" do
      attrs = build(:user_attrs, %{tax_id: "", password: "123"})

      expected = %{
        password: ["should be at least 6 character(s)"],
        tax_id: ["can't be blank"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} =
               Accounts.register_user(attrs)

      assert errors_on(changeset) == expected
    end
  end
end
