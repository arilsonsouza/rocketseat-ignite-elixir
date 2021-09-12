defmodule ExmealWeb.MealsController do
  use ExmealWeb, :controller

  alias Exmeal.Meals

  action_fallback ExmealWeb.FallbackController

  def create(conn, params) do
    with {:ok, meal} <- Meals.create(params) do
      conn
      |> put_status(:created)
      |> render("create.json", meal: meal)
    end
  end
end
