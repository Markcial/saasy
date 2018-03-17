defmodule Saasy.Parser.YmlTest do
  use ExUnit.Case
  alias Saasy.Parser.Yml
  doctest Yml

  test "parse a simple yml string" do
    assert Yml.parse("foo") == {:ok, ['foo']}
  end

  test "parse a list" do
    assert Yml.parse("[1, 2]") == {:ok, [[1, 2]]}
  end

  test "parse a dict" do
    assert Yml.parse("foo: 12") == {:ok, [[{'foo', 12}]]}
  end
end
