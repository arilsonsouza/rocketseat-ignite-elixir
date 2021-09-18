defmodule ExGithubWeb.AccountsController do
  use ExGithubWeb, :controller

  alias ExGithub.Accounts
  alias ExGithubWeb.Auth.Guardian

  action_fallback(ExGithubWeb.FallbackController)

  def create(conn, params) do
    with {:ok, %{user: user, token: token, refresh_token: refresh_token}} <-
           Accounts.register_user(params) do
      conn
      |> put_status(:created)
      |> render("user_registered.json", user: user, token: token, refresh_token: refresh_token)
    end
  end

  def sign_in(conn, params) do
    with {:ok, %{token: token, refresh_token: refresh_token}} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token, refresh_token: refresh_token)
    end
  end

  def refresh_token(conn, params) do
    with {:ok, token} <- Guardian.refresh_token(params) do
      conn
      |> put_status(:ok)
      |> render("refresh_token.json", token: token)
    end
  end
end
