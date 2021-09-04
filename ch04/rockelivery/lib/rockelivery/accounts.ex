defmodule Rockelivery.Accounts do
  alias Rockelivery.Repo
  alias Rockelivery.Accounts.User

  def register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end
end
