defmodule Rockelivery.Repo.Migrations.CreateItemCategoryType do
  use Ecto.Migration

  def up do
    execute("CREATE TYPE item_category AS ENUM ('food', 'drink', 'desert')")
  end

  def down do
    execute("DROP TYPE item_category")
  end
end
