defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.UsersView
  alias Rockelivery.Accounts.User

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created",
             user: %User{
               address: "Mocca",
               birth_date: ~D[1996-03-01],
               cep: "44905000",
               email: "joe@email.com",
               name: "Joe",
               password: "123456",
               password_hash: nil,
               tax_id: "12345678912"
             }
           } = response
  end
end
