defmodule ExGithub.Repositories do
  alias ExGithub.Repositories.Repository

  def get_user_repos(username) do
    with {:ok, repos} <- api_client_adapter().get_user_repos(username),
         repositories <- Repository.build_list(repos) do
      {:ok, repositories}
    else
      reply -> reply
    end
  end

  def api_client_adapter() do
    :ex_github
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:api_client_adapter)
  end
end
