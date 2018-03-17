defmodule Saasy.Loader.JsonTest do
  use ExUnit.Case
  alias Saasy.Loader.Json
  doctest Json

  test "parse a simple json string" do
    assert Json.parse('"foo"') == "foo"
  end

  test "parse a list" do
    assert Json.parse("[1, 2]") == [1,2]
  end

  test "parse a dict" do
    assert Json.parse('{"foo": 12}') == %{"foo" => 12}
  end
end
