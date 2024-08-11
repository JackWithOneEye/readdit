defmodule WithElixirTest do
  use ExUnit.Case
  doctest WithElixir

  test "greets the world" do
    assert WithElixir.hello() == :world
  end
end
