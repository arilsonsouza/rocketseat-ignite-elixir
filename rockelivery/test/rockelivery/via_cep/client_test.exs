defmodule Rockelivery.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias Plug.Conn
  alias Rockelivery.Error
  alias Rockelivery.ViaCep.Client

  setup %{} do
    bypass = Bypass.open()
    url = "http://localhost:#{bypass.port}"

    {:ok, bypass: bypass, url: url}
  end

  describe "get_cep_info/1" do
    test "should return CEP info when CEP is valid", %{bypass: bypass, url: url} do
      cep = "01001000"
      body = ~s({
          "cep": "01001-000",
          "logradouro": "Praça da Sé",
          "complemento": "lado ímpar",
          "bairro": "Sé",
          "localidade": "São Paulo",
          "uf": "SP",
          "ibge": "3550308",
          "gia": "1004",
          "ddd": "11",
          "siafi": "7107"
        })

      Bypass.expect(bypass, "GET", "/#{cep}/json/", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_cep_info(url, cep)

      expected =
        {:ok,
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
         }}

      assert response == expected
    end

    test "should return an error when CEP is invalid", %{bypass: bypass, url: url} do
      cep = "0100"

      Bypass.expect(bypass, "GET", "/#{cep}/json/", fn conn ->
        conn
        |> Conn.resp(400, "")
      end)

      response = Client.get_cep_info(url, cep)

      expected = {:error, %Error{result: "Invalid CEP.", status: :bad_request}}

      assert response == expected
    end

    test "should return an error when CEP was not found", %{bypass: bypass, url: url} do
      cep = "00000000"

      body = ~s({"erro": true})

      Bypass.expect(bypass, "GET", "/#{cep}/json/", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_cep_info(url, cep)

      expected = {:error, %Error{result: "CEP not found.", status: :not_found}}

      assert response == expected
    end

    test "should return an error when there is a generic error", %{bypass: bypass, url: url} do
      cep = "00000000"

      Bypass.down(bypass)

      response = Client.get_cep_info(url, cep)

      expected = {:error, %Error{result: :econnrefused, status: :bad_request}}

      assert response == expected
    end
  end
end
