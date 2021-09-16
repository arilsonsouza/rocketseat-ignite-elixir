defmodule Rockelivery.ViaCep.ClientBehaviour do
  alias Rockelivery.Error
  @callback get_cep_info(cep :: String.t()) :: {:ok, map()} | {:error, Error.t()}
end
