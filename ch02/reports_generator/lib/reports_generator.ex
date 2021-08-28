defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(%{users: %{}, products: %{}}, fn [id, product_name, price],
                                                    %{users: users, products: products} = acc ->
      %{
        acc
        | users: update_map_value(users, id, price, price),
          products: update_map_value(products, product_name, 1, 1)
      }
    end)
  end

  def fetch_higher_cost(%{users: users, products: _products} = _report),
    do: Enum.max_by(users, fn {_id, value} -> value end)

  defp update_map_value(map, key, default, value),
    do: Map.update(map, key, default, fn existing_value -> existing_value + value end)
end
