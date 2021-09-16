defmodule ExGithub.Repositories do
  alias ExGithub.Api.Client
  alias ExGithub.Repositories.Repository

  def get_user_repos(username) do
    with {:ok, repos} <- Client.get_user_repos(username),
         repositories <- Repository.build_list(repos) do
      {:ok, repositories}
    else
      reply -> reply
    end
  end
end
