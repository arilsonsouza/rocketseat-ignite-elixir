defmodule ExmealWeb.MealsControllerTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  setup %{} do
    user_id = Ecto.UUID.generate()
    insert(:user, %{id: user_id})

    {:ok, user_id: user_id}
  end

  describe "create/2" do
    test "should create a meal when all params are present", %{conn: conn, user_id: user_id} do
      params = build(:meal_attrs)

      response =
        conn
        |> post(Routes.meals_path(conn, :create, %{params | "user_id" => user_id}))
        |> json_response(:created)

      assert %{
               "meal" => %{
                 "calories" => 284,
                 "date" => "2021-09-12T01:23:20Z",
                 "description" => "Lasanha",
                 "id" => _
               },
               "message" => "Meal created."
             } = response
    end

    test "should return an error when there are missing params", %{conn: conn} do
      response =
        conn
        |> post(Routes.meals_path(conn, :create, %{}))
        |> json_response(:bad_request)

      assert %{
               "errors" => %{
                 "calories" => ["can't be blank"],
                 "date" => ["can't be blank"],
                 "description" => ["can't be blank"]
               }
             } = response
    end
  end

  describe "update/2" do
    test "should update a meal when id exist", %{conn: conn, user_id: user_id} do
      id = Ecto.UUID.generate()
      insert(:meal, %{id: id, user_id: user_id, description: "Rice and Beans", calories: 450})

      response =
        conn
        |> put(
          Routes.meals_path(conn, :update, id, %{"description" => "Banana", "calories" => 20})
        )
        |> json_response(:ok)

      assert %{
               "meal" => %{
                 "calories" => 20,
                 "date" => "2021-09-12T01:23:20Z",
                 "description" => "Banana",
                 "id" => _
               }
             } = response
    end

    test "should return an error when id not exist", %{conn: conn} do
      id = Ecto.UUID.generate()

      response =
        conn
        |> put(
          Routes.meals_path(conn, :update, id, %{"description" => "Banana", "calories" => 20})
        )
        |> json_response(:not_found)

      assert %{"errors" => "Meal not found."} = response
    end
  end

  describe "show/2" do
    test "should return a meal when id exist", %{conn: conn, user_id: user_id} do
      id = Ecto.UUID.generate()
      insert(:meal, %{id: id, user_id: user_id})

      response =
        conn
        |> get(Routes.meals_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "meal" => %{
                 "calories" => 284,
                 "date" => "2021-09-12T01:23:20Z",
                 "description" => "Lasanha",
                 "id" => _
               }
             } = response
    end

    test "should return an error when id not exist", %{conn: conn} do
      id = Ecto.UUID.generate()

      response =
        conn
        |> get(Routes.meals_path(conn, :show, id))
        |> json_response(:not_found)

      assert %{"errors" => "Meal not found."} = response
    end
  end

  describe "delete/2" do
    test "should delete an meal when is given a valid id", %{conn: conn, user_id: user_id} do
      id = Ecto.UUID.generate()
      insert(:meal, %{id: id, user_id: user_id})

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end

    test "should return an error when is given an invalid id", %{conn: conn} do
      id = Ecto.UUID.generate()

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, id))
        |> json_response(:not_found)

      assert response == %{"errors" => "Meal not found."}
    end
  end
end
