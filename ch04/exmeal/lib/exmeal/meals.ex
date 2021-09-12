defmodule Exmeal.Meals do
  alias Exmeal.Repo
  alias Exmeal.Error
  alias Exmeal.Meals.Meal

  def create(attrs) do
    %Meal{}
    |> Meal.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, %Meal{}} = result -> result
      {:error, changeset} -> {:error, Error.build(:bad_request, changeset)}
    end
  end
end
