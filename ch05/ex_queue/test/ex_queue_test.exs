defmodule ExQueueTest do
  use ExUnit.Case
  doctest ExQueue

  test "greets the world" do
    assert ExQueue.hello() == :world
  end
end
