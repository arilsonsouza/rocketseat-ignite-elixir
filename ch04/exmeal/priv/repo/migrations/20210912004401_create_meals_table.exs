defmodule Exmeal.Repo.Migrations.CreateMealsTable do
  use Ecto.Migration

  def up do
    create table(:meals) do
      add(:description, :string, null: false)
      add(:date, :utc_datetime, null: false)
      add(:calories, :integer, null: false)

      timestamps()
    end
  end

  def down do
    drop table(:meals)
  end
end
