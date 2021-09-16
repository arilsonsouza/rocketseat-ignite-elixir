defmodule ExmealWeb.UsersControllerTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  describe "create/2" do
    test "should create a user when all params are present", %{conn: conn} do
      params = build(:user_attrs)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created.",
               "user" => %{
                 "email" => "jhon4@email.com",
                 "id" => _,
                 "name" => "Jhon",
                 "tax_id" => "00000000002"
               }
             } = response
    end

    test "should return an error when there are missing params", %{conn: conn} do
      response =
        conn
        |> post(Routes.users_path(conn, :create, %{}))
        |> json_response(:bad_request)

      assert %{
               "errors" => %{
                 "email" => ["can't be blank"],
                 "name" => ["can't be blank"],
                 "tax_id" => ["can't be blank"]
               }
             } = response
    end
  end

  describe "update/2" do
    test "should update a user when id exist", %{conn: conn} do
      id = Ecto.UUID.generate()
      insert(:user, %{id: id, name: "Mary", tax_id: "11111111111"})

      response =
        conn
        |> put(
          Routes.users_path(conn, :update, id, %{
            "email" => "rosy@email.com",
            "name" => "Rosy",
            "tax_id" => 32_165_498_798
          })
        )
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "email" => "rosy@email.com",
                 "id" => _,
                 "name" => "Rosy",
                 "tax_id" => "32165498798"
               }
             } = response
    end

    test "should return an error when id not exist", %{conn: conn} do
      id = Ecto.UUID.generate()

      response =
        conn
        |> put(
          Routes.users_path(conn, :update, id, %{"email" => "rosy@email.com", "name" => "Rosy"})
        )
        |> json_response(:not_found)

      assert %{"errors" => "User not found."} = response
    end
  end

  describe "show/2" do
    test "should return a user when id exist", %{conn: conn} do
      id = Ecto.UUID.generate()
      insert(:user, %{id: id})

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "email" => "jhon4@email.com",
                 "id" => _,
                 "name" => "Jhon",
                 "tax_id" => "00000000002"
               }
             } = response
    end

    test "should return an error when id not exist", %{conn: conn} do
      id = Ecto.UUID.generate()

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:not_found)

      assert %{"errors" => "User not found."} = response
    end
  end

  describe "delete/2" do
    test "should delete an user when is given a valid id", %{conn: conn} do
      id = Ecto.UUID.generate()
      insert(:user, %{id: id})

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end

    test "should return an error when is given an invalid id", %{conn: conn} do
      id = Ecto.UUID.generate()

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> json_response(:not_found)

      assert response == %{"errors" => "User not found."}
    end
  end
end
