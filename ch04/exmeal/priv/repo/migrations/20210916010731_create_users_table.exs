defmodule Exmeal.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def up do
    create table(:users) do
      add(:name, :string, null: false)
      add(:tax_id, :string, null: false)
      add(:email, :string, null: false)

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:tax_id])
  end

  def down do
  end
end
