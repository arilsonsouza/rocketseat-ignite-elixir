defmodule Rockelivery.ViaCep.Client do
  use Tesla, only: ~w(get)a

  alias Rockelivery.Error

  @base_url "https://viacep.com.br/ws"
  plug(Tesla.Middleware.JSON)

  adapter(Tesla.Adapter.Hackney, recv_timeout: 60_000)

  def get_cep_info(url \\ @base_url, cep) do
    case get("#{url}/#{cep}/json") do
      {:ok, %{body: %{"erro" => true}}} ->
        {:error, Error.build(:not_found, "CEP not found.")}

      {:ok, %{body: body, status: 200}} ->
        {:ok, body}

      {:ok, %{status: 400}} ->
        {:error, Error.build(:bad_request, "Invalid CEP.")}

      {:error, reason} ->
        {:error, Error.build(:bad_request, reason)}
    end
  end
end
