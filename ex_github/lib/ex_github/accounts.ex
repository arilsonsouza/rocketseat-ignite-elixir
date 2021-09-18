defmodule ExGithub.Accounts do
  alias ExGithub.Repo
  alias ExGithub.Error
  alias ExGithub.Accounts.User
  alias ExGithubWeb.Auth.Guardian

  def register_user(attrs) do
    with {:ok, %User{} = user} <- User.registration_changeset(%User{}, attrs) |> Repo.insert(),
         {:ok, %{token: token, refresh_token: refresh_token}} <- Guardian.authenticate(attrs) do
      {:ok, %{user: user, token: token, refresh_token: refresh_token}}
    else
      {:error, %Error{}} = result ->
        result

      {:error, result} ->
        {:error, Error.build(:bad_request, result)}
    end
  end

  def user_by_id(user_uuid) do
    with %User{} = user <- Repo.get(User, user_uuid) do
      {:ok, user}
    else
      nil -> {:error, Error.user_not_found()}
      :error -> {:error, Error.bad_request()}
    end
  end

  def user_by_email(email) do
    case Repo.get_by(User, email: email) do
      %User{} = user -> {:ok, user}
      nil -> {:error, Error.user_not_found()}
    end
  end
end
