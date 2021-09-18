defmodule ExQueue do
  alias ExQueue.Queue

  defdelegate start_link(state), to: Queue
  defdelegate enqueue(pid, element), to: Queue
  defdelegate dequeue(pid), to: Queue
end
