defmodule RockeliveryWeb.Auth.Guardian do
  use Guardian, otp_app: :rockelivery
  alias Rockelivery.Accounts

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => id}) do
    Accounts.user_by_id(id)
  end
end
