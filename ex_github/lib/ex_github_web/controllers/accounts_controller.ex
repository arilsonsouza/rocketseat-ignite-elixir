defmodule ExGithubWeb.AccountsController do
  use ExGithubWeb, :controller

  alias ExGithub.Accounts

  action_fallback ExGithubWeb.FallbackController

  def create(conn, params) do
    with {:ok, user} <- Accounts.register_user(params) do
      conn
      |> put_status(:created)
      |> render("user_registered.json", user: user)
    end
  end
end
