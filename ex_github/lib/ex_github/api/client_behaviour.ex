defmodule ExGithub.Api.ClientBehaviour do
  alias ExGithub.Error
  @callback get_user_repos(username :: String.t()) :: {:ok, list()} | {:error, Error.t()}
end
