defmodule Exmeal.UsersTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.{Users, Error}

  describe "create/1" do
    test "should return an user when all attrs are valid" do
      attrs = build(:user_attrs)

      response = Users.create(attrs)

      assert {
               :ok,
               %Users.User{
                 id: _,
                 email: "jhon4@email.com",
                 name: "Jhon",
                 tax_id: "00000000002"
               }
             } = response
    end

    test "should return an error when there are missing attrs" do
      expected = %{
        email: ["can't be blank"],
        name: ["can't be blank"],
        tax_id: ["can't be blank"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = Users.create(%{})

      assert errors_on(changeset) == expected
    end
  end

  describe "user_by_id/1" do
    test "should return an user when is given a valid id" do
      id = Ecto.UUID.generate()
      insert(:user, %{id: id})

      response = Users.user_by_id(id)

      assert {
               :ok,
               %Users.User{
                 id: _,
                 email: "jhon4@email.com",
                 name: "Jhon",
                 tax_id: "00000000002"
               }
             } = response
    end

    test "should return an error when is given an invalid id" do
      response = Users.user_by_id(Ecto.UUID.generate())

      assert {:error, %Error{result: "User not found.", status: :not_found}} = response
    end
  end

  describe "update_user_by_id/1" do
    test "should return an updated user when is given a valid id" do
      id = Ecto.UUID.generate()
      insert(:user, %{id: id})

      response =
        Users.update_user_by_id(%{"id" => id, "name" => "Rosy", "email" => "rosy@email.com"})

      assert {
               :ok,
               %Users.User{
                 id: _,
                 email: "rosy@email.com",
                 name: "Rosy",
                 tax_id: "00000000002"
               }
             } = response
    end

    test "should return an error when is given a invalid id" do
      id = Ecto.UUID.generate()

      response = Users.update_user_by_id(%{"id" => id, "name" => "Rosy"})

      assert {:error, %Error{result: "User not found.", status: :not_found}} = response
    end
  end

  describe "delete_user_by_id/1" do
    test "should return a deleted user when is given a valid id" do
      id = Ecto.UUID.generate()
      insert(:user, %{id: id})

      response = Users.delete_user_by_id(id)

      assert {
               :ok,
               %Users.User{
                 id: _,
                 email: "jhon4@email.com",
                 name: "Jhon",
                 tax_id: "00000000002"
               }
             } = response
    end

    test "should return an error when is given an invalid id" do
      id = Ecto.UUID.generate()

      response = Users.delete_user_by_id(id)

      assert {:error, %Error{result: "User not found.", status: :not_found}} = response
    end
  end
end
