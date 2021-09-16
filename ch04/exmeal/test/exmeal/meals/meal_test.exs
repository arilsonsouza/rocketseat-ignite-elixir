defmodule Exmeal.Meals.MealTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Ecto.Changeset
  alias Exmeal.Meals.Meal

  describe "changeset/2" do
    test "should return a valid changeset when all attrs are valid" do
      user_id = Ecto.UUID.generate()
      insert(:user, %{id: user_id})

      attrs = build(:meal_attrs)
      response = Meal.changeset(%Meal{}, %{attrs | "user_id" => user_id})

      assert %Changeset{
               changes: %{calories: 284, date: ~U[2021-09-12 01:23:20Z], description: "Lasanha"},
               valid?: true
             } = response
    end

    test "should return an invalid changeset when some attrs are invalid" do
      response = Meal.changeset(%Meal{}, %{})

      expected = %{
        calories: ["can't be blank"],
        date: ["can't be blank"],
        description: ["can't be blank"],
        user_id: ["can't be blank"]
      }

      assert errors_on(response) == expected
    end
  end
end
