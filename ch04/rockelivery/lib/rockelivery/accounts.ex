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
end
