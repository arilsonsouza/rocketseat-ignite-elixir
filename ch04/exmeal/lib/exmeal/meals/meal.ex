defmodule Exmeal.Meals.Meal do
  use Exmeal.Schema

  @fields [:description, :date, :calories]

  @derive {Jason.Encoder, only: [:id, :description, :date, :calories]}

  schema "meals" do
    field(:description, :string)
    field(:date, :utc_datetime)
    field(:calories, :integer)

    timestamps()
  end

  def changeset(%__MODULE__{} = meal, attrs) do
    meal
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
