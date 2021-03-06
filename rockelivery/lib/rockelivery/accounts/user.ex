defmodule Rockelivery.Accounts.User do
  use Rockelivery.Schema

  @virtual_fields [:password]

  @fields [:email, :name, :tax_id, :birth_date, :cep, :address]

  @derive {Jason.Encoder, only: [:id, :name, :email, :birth_date, :cep]}

  alias Rockelivery.Orders.Order

  schema "users" do
    field(:email, :string)
    field(:name, :string)
    field(:tax_id, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:birth_date, :date)
    field(:cep, :string)
    field(:address, :string)

    has_many(:orders, Order)

    timestamps()
  end

  def registration_changeset(%__MODULE__{} = user, attrs) do
    required_fields = @fields ++ @virtual_fields

    user
    |> cast(attrs, required_fields)
    |> validate_required(required_fields)
    |> validate_length(:cep, is: 8)
    |> validate_email()
    |> validate_tax_id()
    |> validate_password()
  end

  def update_changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_length(:cep, is: 8)
    |> validate_email()
    |> validate_tax_id()
  end

  def build(changeset) do
    changeset
    |> apply_action(:insert)
  end

  defp validate_tax_id(changeset) do
    changeset
    |> validate_length(:tax_id, is: 11)
    |> unique_constraint([:tax_id])
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, Rockelivery.Repo)
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
