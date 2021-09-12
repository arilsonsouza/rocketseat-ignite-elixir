defmodule ExmealWeb.MealsControllerTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  describe "create/2" do
    test "should create a meal when all params are present", %{conn: conn} do
      params = build(:meal_attrs)

      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
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
    test "should update a meal when id exist", %{conn: conn} do
      id = Ecto.UUID.generate()
      insert(:meal, %{id: id, description: "Rice and Beans", calories: 450})

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
    test "should return a meal when id exist", %{conn: conn} do
      id = Ecto.UUID.generate()
      insert(:meal, %{id: id})

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
end
