defmodule RockeliveryWeb.PagesController do
  use RockeliveryWeb, :controller

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Rockelivery is running!"})
  end
end
