defmodule ExGithubWeb.RepositoriesView do
  use ExGithubWeb, :view

  def render("repos.json", %{repos: repos}), do: repos
end
