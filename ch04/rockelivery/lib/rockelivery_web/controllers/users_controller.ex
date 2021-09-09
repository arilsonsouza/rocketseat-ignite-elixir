defmodule RockeliveryWeb.UsersController do
  use RockeliveryWeb, :controller

  alias Rockelivery.Accounts

  action_fallback RockeliveryWeb.FallbackController

  def create(conn, params) do
    with {:ok, user} <- Accounts.register_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Accounts.user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def update(conn, params) do
    with {:ok, user} <- Accounts.update_user_by_id(params) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _user} <- Accounts.delete_user_by_id(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end
