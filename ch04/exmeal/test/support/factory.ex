defmodule Exmeal.Factory do
  use ExMachina.Ecto, repo: Exmeal.Repo

  alias Exmeal.Meals.Meal

  def meal_attrs_factory() do
    %{
      "description" => "Lasanha",
      "date" => "2021-09-12 01:23:20.236267Z",
      "calories" => 284
    }
  end

  def meal_factory() do
    %Meal{
      description: "Lasanha",
      date: "2021-09-12 01:23:20.236267Z",
      calories: 284
    }
  end
end
