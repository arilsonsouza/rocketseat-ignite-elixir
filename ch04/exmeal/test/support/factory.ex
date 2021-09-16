defmodule Exmeal.Factory do
  use ExMachina.Ecto, repo: Exmeal.Repo

  alias Exmeal.Meals.Meal
  alias Exmeal.Users.User

  def user_attrs_factory() do
    %{
      tax_id: "00000000002",
      email: "jhon4@email.com",
      name: "Jhon"
    }
  end

  def user_factory() do
    %User{
      tax_id: "00000000002",
      email: "jhon4@email.com",
      name: "Jhon"
    }
  end

  def meal_attrs_factory() do
    %{
      "description" => "Lasanha",
      "date" => "2021-09-12 01:23:20.236267Z",
      "calories" => 284,
      "user_id" => nil
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
