defmodule ReportsGenerator do
  def build(filename) do
    case File.read("reports/#{filename}") do
      {:ok, file_conent} -> file_conent
      {:error, reason} -> reason
    end
  end
end
