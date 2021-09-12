defmodule Rockelivery.Items.Item do
  use Rockelivery.Schema

  @fields [:category, :description, :price, :photo]

  @derive {Jason.Encoder, only: [:id] ++ @fields}

  @items_categories [:food, :drink, :desert]

  alias Rockelivery.Orders.Order

  schema "items" do
    field(:category, Ecto.Enum, values: @items_categories)
    field(:description, :string)
    field(:price, :decimal)
    field(:photo, :string)

    many_to_many(:orders, Order, join_through: "orders_items")

    timestamps()
  end

  def changeset(%__MODULE__{} = item, attrs) do
    item
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_length(:description, min: 6)
    |> validate_number(:price, greater_than: 0)
  end
end
