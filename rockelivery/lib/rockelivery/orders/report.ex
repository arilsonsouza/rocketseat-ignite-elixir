defmodule Rockelivery.Orders.Report do
  import Ecto.Query
  alias Rockelivery.{Repo, Orders.Order, Items.Item}

  def create(filename \\ "report.csv") do
    query = from(order in Order, order_by: order.user_id)

    {:ok, orders} =
      Repo.transaction(
        fn ->
          query
          |> Repo.stream()
          |> Stream.chunk_every(500)
          |> Stream.flat_map(fn chunck -> Repo.preload(chunck, :items) end)
          |> Enum.map(&parse_line/1)
        end,
        timeout: :infinity
      )

    File.write(filename, orders)
  end

  defp parse_line(%Order{user_id: user_id, payment_type: payment_type, items: items}) do
    items_str =
      items
      |> Enum.map(fn %Item{category: category, description: description, price: price} ->
        "#{category},#{description},#{price}"
      end)
      |> Enum.join(",")

    amount =
      items
      |> Enum.reduce(Decimal.new("0.00"), fn %Item{price: price}, acc ->
        Decimal.add(acc, price)
      end)

    "#{user_id},#{payment_type},#{items_str},#{amount}\n"
  end
end
