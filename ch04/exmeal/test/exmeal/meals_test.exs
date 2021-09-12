defmodule Exmeal.MealsTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.{Meals, Error}

  describe "create/1" do
    test "should return a meal when all attrs are valid" do
      attrs = build(:meal_attrs)

      response = Meals.create(attrs)

      assert {
               :ok,
               %Meals.Meal{
                 calories: 284,
                 date: ~U[2021-09-12 01:23:20Z],
                 description: "Lasanha",
                 id: _
               }
             } = response
    end

    test "should return an error when there are missing attrs" do
      expected = %{
        calories: ["can't be blank"],
        date: ["can't be blank"],
        description: ["can't be blank"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = Meals.create(%{})

      assert errors_on(changeset) == expected
    end
  end
end
