defmodule ExGithub.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def up do
    create table(:users) do
      add(:email, :string, null: false)
      add(:name, :string, null: false)
      add(:password_hash, :string, null: false)

      timestamps()
    end

    create unique_index(:users, [:email])
  end

  def down do

  end
end
