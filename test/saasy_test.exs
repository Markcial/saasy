defmodule SaasyTest do
  use ExUnit.Case
  doctest Saasy

  test "greets the world" do
    assert Saasy.hello() == :world
  end
end
