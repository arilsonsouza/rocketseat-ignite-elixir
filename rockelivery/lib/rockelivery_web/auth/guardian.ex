defmodule RockeliveryWeb.Auth.Guardian do
  use Guardian, otp_app: :rockelivery
  alias Rockelivery.Accounts
  alias Rockelivery.Accounts.User
  alias Rockelivery.Error

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => id}) do
    Accounts.user_by_id(id)
  end

  def authenticate(%{"email" => email, "password" => password}) do
    with {:ok, %User{password_hash: password_hash} = user} <- Accounts.user_by_email(email),
         true <- Pbkdf2.verify_pass(password, password_hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials.")}
      reply -> reply
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params.")}
end
