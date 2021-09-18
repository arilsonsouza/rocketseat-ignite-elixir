defmodule ExGithubWeb.AccountsView do
  use ExGithubWeb, :view

  def render("user_registered.json", %{user: user}), do: %{user: user}
end
