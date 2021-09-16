defmodule ExmealWeb.UsersViewTest do
  use ExmealWeb.ConnCase, async: true

  import Phoenix.View
  import Exmeal.Factory

  alias Exmeal.Users.User
  alias ExmealWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created.",
             user: %User{
               email: "jhon4@email.com",
               name: "Jhon",
               tax_id: "00000000002"
             }
           } = response
  end
end
