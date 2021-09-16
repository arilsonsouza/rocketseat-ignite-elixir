defmodule Exmeal.Repo.Migrations.AddUserIdToMealsTable do
  use Ecto.Migration

  def up do
    alter table(:meals) do
      add(:user_id, references(:users, type: :uuid), null: false)
    end

    create index(:meals, [:user_id])
  end

  def down do
  end
end
