defmodule ExGithub.Factory do
  use ExMachina.Ecto, repo: ExGithub.Repo

  alias ExGithub.Accounts.User

  def repository_factory() do
    %{
      "id" => 400_676_905,
      "name" => "rocketseat-ignite-elixir",
      "description" =>
        "This repo holds all challenges and projects developed by me during the \"Rocketseat Ignite: Elixir\" course.",
      "html_url" => "https://github.com/arilsonsouza/rocketseat-ignite-elixir",
      "stargazers_count" => 0
    }
  end

  def user_attrs_factory() do
    %{
      "email" => "joe@email.com",
      "name" => "Joe",
      "password" => "123456"
    }
  end
end
