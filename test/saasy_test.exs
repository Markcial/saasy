defmodule SaasyTest do
  use ExUnit.Case
  doctest Saasy

  test "The feeds folder from the project matches the one in the configuration" do
    assert Saasy.feeds_folder() == Application.get_env(:saasy, :feeds_folder)
  end

  test "The feeds folder is a real folder" do
    assert Saasy.feeds_folder()
           |> File.exists?()
  end

  test "Normalize softwareadvice data structure" do
    assert Saasy.normalize(
      %{
        "products" => []
      },
      "products"
    ) == []
  end

end
