defmodule Rockelivery.Factory do
  use ExMachina

  def user_attrs_factory() do
    %{
      email: "joe@email.com",
      name: "Joe",
      tax_id: "12345678912",
      password: "123456",
      birth_date: ~D[1996-03-01],
      cep: "44905000",
      address: "Mocca"
    }
  end
end
