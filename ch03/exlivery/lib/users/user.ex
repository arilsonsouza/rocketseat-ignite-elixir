defmodule Exlivery.Users.User do
  @keys [:name, :email, :tax_id, :age]
  @enforce_keys @keys

  defstruct @keys

  def build(name, email, tax_id, age) when age >= 18 do
    {:ok, %__MODULE__{name: name, email: email, tax_id: tax_id, age: age}}
  end

  def build(_name, _email, _tax_id, _age), do: {:error, :invalid_parameters}
end
