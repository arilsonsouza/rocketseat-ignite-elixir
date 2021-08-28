defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(%{}, fn [id, _product_name, price], acc ->
      Map.update(acc, id, price, fn existing_value -> existing_value + price end)
    end)
  end
end
