defmodule ExmealWeb.MealsViewTest do
  use ExmealWeb.ConnCase, async: true

  import Phoenix.View
  import Exmeal.Factory

  alias Exmeal.Meals.Meal
  alias ExmealWeb.MealsView

  test "renders create.json" do
    meal = build(:meal)

    response = render(MealsView, "create.json", meal: meal)

    assert %{
             message: "Meal created.",
             meal: %Meal{
               calories: 284,
               date: "2021-09-12 01:23:20.236267Z",
               description: "Lasanha"
             }
           } = response
  end
end
