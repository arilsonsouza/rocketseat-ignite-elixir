defmodule Rockelivery.Repo.Migrations.CreateOrdersTable do
  use Ecto.Migration

  def up do
    create table(:orders) do
      add(:address, :string)
      add(:comments, :string)
      add(:payment_type, :payment_type)

      add(:user_id, references(:users, type: :uuid), null: false)

      timestamps()
    end
  end

  def down do
  end
end
