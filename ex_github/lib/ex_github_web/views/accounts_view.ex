defmodule ExGithubWeb.AccountsView do
  use ExGithubWeb, :view

  def render("user_registered.json", %{user: user, token: token, refresh_token: refresh_token}),
    do: %{user: user, token: token, refresh_token: refresh_token}

  def render("sign_in.json", %{token: token, refresh_token: refresh_token}),
    do: %{token: token, refresh_token: refresh_token}

  def render("refresh_token.json", %{token: token}), do: %{token: token}
end
