defmodule Saasy.Normalizer.SoftwareadviceTest do
  use ExUnit.Case
  alias Saasy.Normalizer.Softwareadvice
  doctest Softwareadvice

  test "Normalize sample data structure, collection" do
  end

  test "Testing first fixture" do
    assert Softwareadvice.normalize(%{
             "products" => [
               %{
                 "categories" => ["Customer Service", "Call Center"],
                 "title" => "Freshdesk",
                 "twitter" => "@freshdesk"
               },
               %{"categories" => ["CRM", "Sales Management"], "title" => "Zoho"}
             ]
           }) ==
             {:ok,
              [
                %{
                  categories: ["Customer Service", "Call Center"],
                  name: "Freshdesk",
                  twitter: "@freshdesk"
                },
                %{
                  categories: ["CRM", "Sales Management"],
                  name: "Zoho"
                }
              ]}
  end
end
