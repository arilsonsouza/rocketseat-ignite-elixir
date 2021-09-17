defmodule ExGithub.Api.ClientTest do
  use ExUnit.Case, async: true

  alias Plug.Conn
  alias ExGithub.Api.Client

  describe "get_user_repos/1" do
    setup %{} do
      bypass = Bypass.open()
      url = "http://localhost:#{bypass.port}"

      {:ok, bypass: bypass, url: url}
    end

    test "should return user repos when username is valid", %{bypass: bypass, url: url} do
      username = "arilsonsouza"

      body = ~s([{
          "id": 400676905,
          "name": "rocketseat-ignite-elixir",
          "description": "This repo holds all challenges and projects developed by me during the \\"Rocketseat Ignite: Elixir\\" course.",
          "html_url": "https://github.com/arilsonsouza/rocketseat-ignite-elixir",
          "stargazers_count":0
        }])

      Bypass.expect(bypass, "GET", "/#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_user_repos(url, username)

      expected =
        {:ok,
         [
           %{
             "description" =>
               "This repo holds all challenges and projects developed by me during the \"Rocketseat Ignite: Elixir\" course.",
             "html_url" => "https://github.com/arilsonsouza/rocketseat-ignite-elixir",
             "id" => 400_676_905,
             "name" => "rocketseat-ignite-elixir",
             "stargazers_count" => 0
           }
         ]}

      assert response == expected
    end

    test "should return an error when username is invalid", %{bypass: bypass, url: url} do
      username = "arilsonsouza123456789789"

      body = ~s({
        "message": "Not Found",
        "documentation_url": "https://docs.github.com/rest/reference/repos#list-repositories-for-a-user"
      })

      Bypass.expect(bypass, "GET", "/#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(404, body)
      end)

      response = Client.get_user_repos(url, username)

      expected = {:error, %ExGithub.Error{result: "User not found.", status: :not_found}}

      assert response == expected
    end
  end
end
