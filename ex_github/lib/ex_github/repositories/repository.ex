defmodule ExGithub.Repositories.Repository do
  @keys [:id, :name, :description, :html_url, :stargazers_count]
  @enforce_keys @keys

  @derive {Jason.Encoder, only: @keys}

  defstruct @keys

  @type t :: %__MODULE__{}

  def build_list(repositories) do
    repositories
    |> Enum.map(fn %{
                     "id" => id,
                     "name" => name,
                     "description" => description,
                     "html_url" => html_url,
                     "stargazers_count" => stargazers_count
                   } ->
      %__MODULE__{
        id: id,
        name: name,
        description: description,
        html_url: html_url,
        stargazers_count: stargazers_count
      }
    end)
  end
end
