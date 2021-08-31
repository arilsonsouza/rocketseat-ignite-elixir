defmodule GenReport do
  alias GenReport.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(
      %{"all_hours" => %{}, "hours_per_month" => %{}, "hours_per_year" => %{}},
      fn [name, qtd_hours, _day, month, year],
         %{
           "all_hours" => all_hours,
           "hours_per_month" => hours_per_month,
           "hours_per_year" => hours_per_year
         } = acc ->
        %{
          acc
          | "all_hours" => update_map_value(all_hours, name, qtd_hours, qtd_hours, &sum_values/2),
            "hours_per_month" =>
              update_nested_map_value(
                hours_per_month,
                name,
                month,
                qtd_hours,
                &sum_values/2
              ),
            "hours_per_year" =>
              update_nested_map_value(
                hours_per_year,
                name,
                year,
                qtd_hours,
                &sum_values/2
              )
        }
      end
    )
  end

  def build(), do: {:error, "Insira o nome de um arquivo"}

  defp update_nested_map_value(map, key, nested_key, default \\ 0, value, fun) do
    update_in(
      map,
      [Access.key(key, %{}), Access.key(nested_key, default)],
      &fun.(&1, value)
    )
  end

  def update_map_value(map, key, default, value, fun),
    do: Map.update(map, key, default, &fun.(&1, value))

  defp sum_values(first_value, second_value), do: first_value + second_value
end
