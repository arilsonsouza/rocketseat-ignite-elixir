defmodule ReportsGenerator do
  def build(filename) do
    "reports/#{filename}"
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, file_conent}), do: file_conent
  defp handle_file({:error, _reason}), do: "Error when opening file!"
end
