defmodule ExGithubWeb.Auth.Guardian do
  use Guardian, otp_app: :ex_github
  alias ExGithub.Accounts
  alias ExGithub.Accounts.User
  alias ExGithub.Error

  @token_ttl {1, :hour}
  @refresh_token_ttl {4, :weeks}

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
         {:ok, token, _claims} <- create_token(user, "access", @token_ttl),
         {:ok, refresh_token, _claims} <- create_token(user, "refresh", @refresh_token_ttl) do
      {:ok, %{token: token, refresh_token: refresh_token}}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials.")}
      reply -> reply
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params.")}

  def refresh_token(%{"token" => old_token, "refresh_token" => refresh_token}) do
    with {:ok, _, {new_token_refresh, _}} <- token_refresh(refresh_token),
         {:ok, _, {new_token, _}} <- exchange_token(new_token_refresh),
         {:ok, _claims} <- revoke(old_token) do
      {:ok, new_token}
    else
      error ->
        IO.inspect(error)
        {:error, Error.build(:unauthorized, "Token invalid or expired.")}
    end
  end

  def refresh_token(_), do: {:error, Error.build(:bad_request, "Invalid or missing params.")}

  defp token_refresh(old_token) do
    refresh(old_token, ttl: @token_ttl)
  end

  defp exchange_token(token) do
    exchange(token, "refresh", "access", ttl: @token_ttl)
  end

  defp create_token(user, token_type, ttl) do
    encode_and_sign(user, %{}, token_type: token_type, ttl: ttl)
  end
end
