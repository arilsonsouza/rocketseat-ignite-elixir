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
end
