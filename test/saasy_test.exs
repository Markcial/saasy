defmodule SaasyTest do
  use ExUnit.Case
  doctest Saasy

  test "The feeds folder from the project matches the one in the configuration" do
    assert Saasy.feeds_folder() == Application.get_env(:saasy, :feeds_folder)
  end

  test "The feeds folder is a real folder" do
    assert Saasy.feeds_folder |>
      File.exists?
  end

  test "Loader for .yml files" do
    assert Saasy.get_loader("foo.yml") == {:ok, Saasy.Loader.Yml}
  end

  test "Loader for .yml files (imperative)" do
    assert Saasy.get_loader!("foo.yml") == Saasy.Loader.Yml
  end

  test "Loader for .yaml files" do
    assert Saasy.get_loader("foo.yaml") == {:ok, Saasy.Loader.Yml}
  end

  test "Loader for .yaml files (imperative)" do
    assert Saasy.get_loader!("foo.yaml") == Saasy.Loader.Yml
  end

  test "Loader for .json files" do
    assert Saasy.get_loader("foo.json") == {:ok, Saasy.Loader.Json}
  end

  test "Loader for .json files (imperative)" do
    assert Saasy.get_loader!("foo.json") == Saasy.Loader.Json
  end

  test "Loader not implemented yet" do
    assert Saasy.get_loader("foo.csv") == {:error, "Not Implemented!"}
  end

  test "Loader not implemented yet (imperative)" do
    assert_raise RuntimeError, ~s"Not Implemented!", fn ->
      Saasy.get_loader!("foo.csv")
    end
  end
end
