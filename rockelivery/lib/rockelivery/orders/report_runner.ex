defmodule Rockelivery.Orders.ReportRunner do
  use GenServer

  require Logger

  alias Rockelivery.Orders.Report

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state) do
    schedule_report_generation()
    {:ok, state}
  end

  @impl true
  def handle_info(:generate_report, state) do
    Logger.info("Generating report...")
    schedule_report_generation()
    Report.create()
    {:noreply, state}
  end

  defp schedule_report_generation() do
    Process.send_after(self(), :generate_report, :timer.hours(24))
  end
end
