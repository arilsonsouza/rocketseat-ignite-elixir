defmodule Rockelivery.Accounts do
  alias Rockelivery.Repo
  alias Rockelivery.Accounts.User
  alias Rockelivery.Error

  def register_user(attrs) do
    cep = Map.get(attrs, "cep")

    with {:ok, %User{} = user} <- User.registration_changeset(%User{}, attrs) |> User.build(),
         {:ok, _cep_info} <- via_cep_adapter().get_cep_info(cep),
         {:ok, %User{}} = result <- Repo.insert(user) do
      result
    else
      {:error, %Error{}} = error ->
        error

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

  def delete_user_by_id(user_uuid) do
    case user_by_id(user_uuid) do
      {:ok, user} -> Repo.delete(user)
      reply -> reply
    end
  end

  def update_user_by_id(%{"id" => user_uuid} = params) do
    case user_by_id(user_uuid) do
      {:ok, user} ->
        user
        |> User.update_changeset(params)
        |> Repo.update()

      reply ->
        reply
    end
  end

  def user_by_email(email) do
    case Repo.get_by(User, email: email) do
      %User{} = user -> {:ok, user}
      nil -> {:error, Error.user_not_found()}
    end
  end

  defp via_cep_adapter() do
    :rockelivery
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:via_cep_adapter)
  end
end
