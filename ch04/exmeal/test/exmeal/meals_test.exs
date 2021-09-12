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

  describe "by_id/1" do
    test "should return a meal when is given a valid id" do
      id = Ecto.UUID.generate()
      insert(:meal, %{id: id})

      response = Meals.by_id(id)

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

    test "should return an error when is given an invalid id" do
      response = Meals.by_id(Ecto.UUID.generate())

      assert {:error, %Exmeal.Error{result: "Meal not found.", status: :not_found}} = response
    end
  end

  describe "update/1" do
    test "should return an updated meal when is given a valid id" do
      id = Ecto.UUID.generate()
      insert(:meal, %{id: id})

      response = Meals.update(%{"id" => id, "calories" => 20, "description" => "Banana"})

      assert {
               :ok,
               %Exmeal.Meals.Meal{
                 calories: 20,
                 date: ~U[2021-09-12 01:23:20Z],
                 description: "Banana",
                 id: _
               }
             } = response
    end

    test "should return an error when is given a invalid id" do
      id = Ecto.UUID.generate()

      response = Meals.update(%{"id" => id, "calories" => 20, "description" => "Banana"})

      assert {:error, %Exmeal.Error{result: "Meal not found.", status: :not_found}} = response
    end
  end

  describe "delete_by_id/1" do
    test "should return a deleted meal when is given a valid id" do
      id = Ecto.UUID.generate()
      insert(:meal, %{id: id})

      response = Meals.delete_by_id(id)

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

    test "should return an error when is given an invalid id" do
      id = Ecto.UUID.generate()

      response = Meals.delete_by_id(id)

      assert {:error, %Error{result: "Meal not found.", status: :not_found}} = response
    end
  end
end
