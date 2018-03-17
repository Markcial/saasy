defmodule Saasy.LoaederTest do
  use ExUnit.Case
  alias Saasy.Parser
  doctest Parser

  test "Parser for .yml files" do
    assert Parser.get("foo.yml") == {:ok, Saasy.Parser.Yml}
  end

  test "Parser for .yml files (imperative)" do
    assert Parser.get!("foo.yml") == Saasy.Parser.Yml
  end

  test "Parser for .yaml files" do
    assert Parser.get("foo.yaml") == {:ok, Saasy.Parser.Yml}
  end

  test "Parser for .yaml files (imperative)" do
    assert Parser.get!("foo.yaml") == Saasy.Parser.Yml
  end

  test "Parser for .json files" do
    assert Parser.get("foo.json") == {:ok, Saasy.Parser.Json}
  end

  test "Parser for .json files (imperative)" do
    assert Parser.get!("foo.json") == Saasy.Parser.Json
  end

  test "Parser not implemented yet" do
    assert Parser.get("foo.csv") == {:error, "Not Implemented!"}
  end

  test "Parser not implemented yet (imperative)" do
    assert_raise RuntimeError, ~s"Not Implemented!", fn ->
      Parser.get!("foo.csv")
    end
  end
end
