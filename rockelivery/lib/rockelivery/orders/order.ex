defmodule Rockelivery.Orders.Order do
  use Rockelivery.Schema

  @fields [:user_id, :address, :comments, :payment_type]

  @derive {Jason.Encoder, only: [:id, :items] ++ @fields}

  @payment_types [:money, :credit_card, :debit_card]

  alias Rockelivery.Items.Item
  alias Rockelivery.Accounts.User

  schema "orders" do
    field(:address, :string)
    field(:comments, :string)
    field(:payment_type, Ecto.Enum, values: @payment_types)

    belongs_to(:user, User)
    many_to_many(:items, Item, join_through: "orders_items")

    timestamps()
  end

  def changeset(%__MODULE__{} = order, attrs, items) do
    order
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> put_assoc(:items, items)
    |> validate_length(:address, min: 10)
    |> validate_length(:comments, min: 6)
  end
end
