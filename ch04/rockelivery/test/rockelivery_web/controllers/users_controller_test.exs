defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

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
        |> post(Routes.users_path(conn, :create, %{"password" => 123, "name" => "mary"}))
        |> json_response(:bad_request)

      assert %{
               "errors" => %{
                 "address" => ["can't be blank"],
                 "birth_date" => ["can't be blank"],
                 "cep" => ["can't be blank"],
                 "email" => ["can't be blank"],
                 "password" => ["should be at least 6 character(s)"],
                 "tax_id" => ["can't be blank"]
               }
             } = response
    end
  end
end
