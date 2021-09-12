defmodule Rockelivery.Orders do
  import Ecto.Query

  alias Rockelivery.Repo
  alias Rockelivery.Error
  alias Rockelivery.Items.Item
  alias Rockelivery.Orders.Order

  def create(params) do
    with {:ok, items} <- fetch_items(params),
         {:ok, _order} = result <- Order.changeset(%Order{}, params, items) |> Repo.insert() do
      result
    else
      {:error, %Error{}} = reply -> reply
      {:error, changeset} -> {:error, Error.build(:bad_request, changeset)}
    end
  end

  defp fetch_items(%{"items" => items_params}) do
    item_ids = Enum.map(items_params, & &1["id"])

    from(item in Item, where: item.id in ^item_ids)
    |> Repo.all()
    |> validate_items(item_ids, items_params)
  end

  defp fetch_items(_params), do: {:error, Error.build(:bad_request, "Order items are required.")}

  defp validate_items(items, item_ids, items_params) do
    items_map = Map.new(items, fn item -> {item.id, item} end)

    item_ids
    |> Enum.map(fn id -> {id, Map.get(items_map, id)} end)
    |> Enum.any?(fn {_id, value} -> is_nil(value) end)
    |> multiply_items(items_map, items_params)
  end

  defp multiply_items(false, items, items_params) do
    items =
      Enum.reduce(items_params, [], fn %{"id" => id, "quantity" => quantity}, acc ->
        item = Map.get(items, id)

        acc ++ List.duplicate(item, quantity)
      end)

    {:ok, items}
  end

  defp multiply_items(true, _items, _items_params),
    do: {:error, Error.build(:bad_request, "Invalid items.")}
end
