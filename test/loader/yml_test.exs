defmodule Saasy.Loader.YmlTest do
  use ExUnit.Case
  alias Saasy.Loader.Yml
  doctest Yml

  test "parse a simple yml string" do
    assert Yml.parse("foo") == ['foo']
  end

  test "parse a list" do
    assert Yml.parse("[1, 2]") == [[1,2]]
  end

  test "parse a dict" do
    assert Yml.parse("foo: 12") == [[{'foo', 12}]]
  end
end
