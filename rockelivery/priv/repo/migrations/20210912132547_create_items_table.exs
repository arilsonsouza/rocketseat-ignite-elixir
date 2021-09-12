defmodule Rockelivery.Repo.Migrations.CreateItemsTable do
  use Ecto.Migration

  def up do
    create table(:items) do
      add(:category, :item_category)
      add(:description, :string)
      add(:price, :decimal)
      add(:photo, :string)

      timestamps()
    end
  end

  def down do

  end
end
