defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.Accounts.User

  def user_attrs_factory() do
    %{
      "email" => "joe@email.com",
      "name" => "Joe",
      "tax_id" => "12345678912",
      "password" => "123456",
      "birth_date" => ~D[1996-03-01],
      "cep" => "44905000",
      "address" => "Mocca"
    }
  end

  def user_factory() do
    %User{
      email: "joe@email.com",
      name: "Joe",
      tax_id: "12345678912",
      password: "123456",
      birth_date: ~D[1996-03-01],
      cep: "44905000",
      address: "Mocca",
      id: "6ab76803-e57b-4147-8598-3b82cf088350"
    }
  end

  def cep_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end
