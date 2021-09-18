defmodule ExGithub.Accounts.User do
  use ExGithub.Schema

  @virtual_fields [:password]

  @fields [:email, :name]

  @derive {Jason.Encoder, only: [:id, :name, :email]}

  schema "users" do
    field(:email, :string)
    field(:name, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)

    timestamps()
  end

  def registration_changeset(%__MODULE__{} = user, attrs) do
    required_fields = @fields ++ @virtual_fields

    user
    |> cast(attrs, required_fields)
    |> validate_required(required_fields)
    |> validate_email()
    |> validate_password()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, ExGithub.Repo)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 80)
    |> maybe_hash_password()
  end

  defp maybe_hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        change(changeset, Pbkdf2.add_hash(password))
        |> delete_change(:password)

      _ ->
        changeset
    end
  end
end
