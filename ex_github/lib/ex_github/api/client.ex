defmodule ExGithub.Api.Client do
  use Tesla, only: ~w(get)a

  alias ExGithub.Error
  alias ExGithub.Api.ClientBehaviour

  @behaviour ClientBehaviour

  @base_url "https://api.github.com/users"

  plug(Tesla.Middleware.JSON)

  adapter(Tesla.Adapter.Hackney, recv_timeout: 60_000)

  def get_user_repos(url \\ @base_url, username) do
    case get("#{url}/#{username}/repos") do
      {:ok, %{status: 200, body: repositories}} -> {:ok, repositories}
      {:ok, %{status: 404}} -> {:error, Error.build(:not_found, "User not found.")}
    end
  end
end
