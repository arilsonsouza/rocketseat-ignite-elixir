defmodule Rockelivery.Repo.Migrations.CreateOrdersItemsTable do
  use Ecto.Migration

  def up do
    create table(:orders_items, primary_key: false) do
      add(:order_id, references(:orders, type: :uuid), null: false)
      add(:item_id, references(:items, type: :uuid), null: false)
    end
  end

  def down do
  end
end
