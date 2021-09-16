defmodule ExGithubWeb.RepositoriesController do
  use ExGithubWeb, :controller

  alias ExGithub.Repositories

  action_fallback ExGithubWeb.FallbackController

  def get_user_repos(conn, %{"username" => username}) do
    with {:ok, repositories} <- Repositories.get_user_repos(username) do
      conn
      |> put_status(:ok)
      |> render("repos.json", repos: repositories)
    end
  end
end
