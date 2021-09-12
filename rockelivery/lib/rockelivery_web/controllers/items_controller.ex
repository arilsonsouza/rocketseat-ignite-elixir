defmodule RockeliveryWeb.ItemsController do
  use RockeliveryWeb, :controller

  alias Rockelivery.Items

  action_fallback RockeliveryWeb.FallbackController

  def create(conn, params) do
    with {:ok, item} <- Items.create(params) do
      conn
      |> put_status(:created)
      |> render("create.json", item: item)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, item} <- Items.by_id(id) do
      conn
      |> put_status(:ok)
      |> render("item.json", item: item)
    end
  end

  def update(conn, params) do
    with {:ok, item} <- Items.update_by_id(params) do
      conn
      |> put_status(:ok)
      |> render("item.json", item: item)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _item} <- Items.delete_by_id(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end
