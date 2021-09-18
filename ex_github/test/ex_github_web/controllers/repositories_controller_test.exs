defmodule ExGithubWeb.RepositoriesControllerTest do
  use ExGithubWeb.ConnCase, async: true

  import Mox
  import ExGithub.Factory

  alias ExGithub.Accounts
  alias ExGithub.Api.ClientMock

  describe "get_user_repos/1" do
    setup %{conn: conn} do
      {:ok, %{token: token}} = Accounts.register_user(build(:user_attrs))

      conn =
        conn
        |> put_req_header("authorization", "Bearer #{token}")

      {:ok, conn: conn}
    end

    test "should return user repos when username is valid", %{conn: conn} do
      expect(ClientMock, :get_user_repos, fn _username -> {:ok, build_list(1, :repository)} end)

      response =
        conn
        |> get(Routes.repositories_path(conn, :get_user_repos, "arilsonsouza"))
        |> json_response(:ok)

      expected = [
        %{
          "description" =>
            "This repo holds all challenges and projects developed by me during the \"Rocketseat Ignite: Elixir\" course.",
          "html_url" => "https://github.com/arilsonsouza/rocketseat-ignite-elixir",
          "id" => 400_676_905,
          "name" => "rocketseat-ignite-elixir",
          "stargazers_count" => 0
        }
      ]

      assert response == expected
    end

    test "should return an error when username is invalid", %{conn: conn} do
      expect(ClientMock, :get_user_repos, fn _username ->
        {:error, %ExGithub.Error{result: "User not found.", status: :not_found}}
      end)

      response =
        conn
        |> get(Routes.repositories_path(conn, :get_user_repos, "arilsonsouza123456987"))
        |> json_response(:not_found)

      expected = %{"errors" => "User not found."}

      assert response == expected
    end
  end
end
