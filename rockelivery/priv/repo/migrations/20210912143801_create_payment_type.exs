defmodule Rockelivery.Repo.Migrations.CreatePaymentType do
  use Ecto.Migration

  def up do
    execute("CREATE TYPE payment_type AS ENUM('money', 'credit_card', 'debit_card')")
  end

  def down do
    execute("DROP TYPE payment_type")
  end
end
