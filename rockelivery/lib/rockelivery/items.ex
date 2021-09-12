defmodule Rockelivery.Items do
  alias Rockelivery.Repo
  alias Rockelivery.Error
  alias Rockelivery.Items.Item

  def create(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, %Item{}} = result -> result
      {:error, changeset} -> {:error, Error.build(:bad_request, changeset)}
    end
  end

  def by_id(item_uuid) do
    with %Item{} = item <- Repo.get(Item, item_uuid) do
      {:ok, item}
    else
      nil -> {:error, Error.build(:not_found, "Item not found.")}
      :error -> {:error, Error.bad_request()}
    end
  end

  def delete_by_id(item_uuid) do
    case by_id(item_uuid) do
      {:ok, item} -> Repo.delete(item)
      reply -> reply
    end
  end

  def update_by_id(%{"id" => item_uuid} = params) do
    case by_id(item_uuid) do
      {:ok, item} ->
        item
        |> Item.changeset(params)
        |> Repo.update()

      reply ->
        reply
    end
  end
end
