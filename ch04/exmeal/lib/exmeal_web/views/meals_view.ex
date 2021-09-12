defmodule ExmealWeb.MealsView do
  use ExmealWeb, :view

  alias Exmeal.Meals.Meal

  def render("create.json", %{meal: %Meal{} = meal}) do
    %{message: "Meal created.", meal: meal}
  end
end
