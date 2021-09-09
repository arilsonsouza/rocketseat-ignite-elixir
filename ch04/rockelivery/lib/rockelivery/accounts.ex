defmodule Rockelivery.Accounts do
  alias Rockelivery.Repo
  alias Rockelivery.Accounts.User
  alias Rockelivery.Error

  def register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, %User{}} = result -> result
      {:error, changeset} -> {:error, Error.build(:bad_request, changeset)}
    end
  end

  def user_by_id(user_uuid) do
    with {:ok, _uuid} <- Ecto.UUID.cast(user_uuid),
         %User{} = user <- Repo.get(User, user_uuid) do
      {:ok, user}
    else
      nil -> {:error, Error.user_not_found()}
      :error -> {:error, Error.bad_request()}
    end
  end

  def delete_user_by_id(user_uuid) do
    case user_by_id(user_uuid) do
      {:ok, user} -> Repo.delete(user)
      reply -> reply
    end
  end
end
