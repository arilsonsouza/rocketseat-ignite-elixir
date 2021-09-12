defmodule Rockelivery.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def up do
    create table(:users) do
      add(:email, :string)
      add(:name, :string)
      add(:tax_id, :string)
      add(:password_hash, :string)
      add(:birth_date, :date)
      add(:cep, :string)
      add(:address, :string)

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:tax_id])
  end

  def down do
  end
end
