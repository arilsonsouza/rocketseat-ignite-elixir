defmodule RockeliveryWeb.OrdersController do
  use RockeliveryWeb, :controller

  alias Rockelivery.Orders

  action_fallback RockeliveryWeb.FallbackController

  def create(conn, params) do
    with {:ok, order} <- Orders.create(params) do
      conn
      |> put_status(:created)
      |> render("create.json", order: order)
    end
  end
end
