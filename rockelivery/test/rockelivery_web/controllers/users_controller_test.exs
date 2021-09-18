defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Mox
  import Rockelivery.Factory

  alias RockeliveryWeb.Auth.Guardian
  alias Rockelivery.ViaCep.ClientMock

  setup %{} do
    params = %{
      "email" => "joe@email.com",
      "name" => "Joe",
      "tax_id" => "12345678912",
      "password" => "123456",
      "birth_date" => "1996-03-01",
      "cep" => "44905000",
      "address" => "Mocca"
    }

    {:ok, params: params}
  end

  describe "create/2" do
    test "should register an user when all params are valid", %{conn: conn, params: params} do
      expect(ClientMock, :get_cep_info, fn _cep -> {:ok, build(:cep_info)} end)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created",
               "user" => %{
                 "birth_date" => "1996-03-01",
                 "cep" => "44905000",
                 "email" => "joe@email.com",
                 "id" => _id,
                 "name" => "Joe"
               }
             } = response
    end

    test "should return an error when are invalid params", %{conn: conn} do
      response =
        conn
        |> post(
          Routes.users_path(conn, :create, %{
            "password" => 123,
            "name" => "mary",
            "cep" => "00000000"
          })
        )
        |> json_response(:bad_request)

      assert %{
               "errors" => %{
                 "address" => ["can't be blank"],
                 "birth_date" => ["can't be blank"],
                 "email" => ["can't be blank"],
                 "password" => ["should be at least 6 character(s)"],
                 "tax_id" => ["can't be blank"]
               }
             } = response
    end
  end

  describe "delete/2" do
    setup %{conn: conn} do
      user = insert(:user, %{id: "6ab76803-e57b-4147-8598-3b82cf088350"})
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "should delete a user when user_id is valid", %{conn: conn, user: user} do
      response =
        conn
        |> delete(Routes.users_path(conn, :delete, user.id))
        |> response(:no_content)

      assert response == ""
    end

    test "should return an error when not exists a user for the given uuid", %{conn: conn} do
      id = "c1a8c88b-dbd2-43c7-b67e-eeaba89ee7ba"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> json_response(:not_found)

      assert response == %{"errors" => "User not found"}
    end

    test "should return an error when receives an invalid uuid", %{conn: conn} do
      id = "c1a8c88b-dbd2"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> json_response(:bad_request)

      assert response == %{"message" => "Invalid request format!"}
    end
  end
end
