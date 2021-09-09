defmodule Rockelivery.Accounts do
  alias Rockelivery.Repo
  alias Rockelivery.Accounts.User

  def register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, %User{}} = result -> result
      {:error, changeset} -> {:error, %{status: :bad_request, result: changeset}}
    end
  end

  def user_by_id(user_uuid) do
    with {:ok, _uuid} <- Ecto.UUID.cast(user_uuid),
         %User{} = user <- Repo.get(User, user_uuid) do
      {:ok, user}
    else
      nil -> {:error, %{status: :not_found, result: "User not found!"}}
      :error -> {:error, %{status: :bad_request, result: "Invalid user id!"}}
    end
  end

  def delete_user_by_id(user_uuid) do
    case user_by_id(user_uuid) do
      {:ok, user} -> Repo.delete(user)
      reply -> reply
    end
  end
end
