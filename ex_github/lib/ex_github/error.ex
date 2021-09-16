defmodule ExGithub.Error do
  @keys [:status, :result]
  @enforce_keys @keys

  defstruct @keys

  @type t :: %__MODULE__{}

  def build(status, result) do
    %__MODULE__{status: status, result: result}
  end

  def bad_request(), do: build(:bad_request, "Invalid request format")
end
