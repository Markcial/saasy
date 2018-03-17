defmodule Saasy.Normalizer.CapterraTest do
  use ExUnit.Case
  alias Saasy.Normalizer.Capterra
  doctest Capterra

  test "Normalize sample data structure, collection" do
    assert Capterra.normalize([
             [
               [
                 {'tags', 'foo,bar'},
                 {'name', 'name'},
                 {'twitter', 'twitter'}
               ]
             ]
           ]) ==
             {:ok,
              [
                %{
                  categories: ["foo", "bar"],
                  name: "name",
                  twitter: "@twitter"
                }
              ]}
  end

  test "Testing first fixture" do
    assert Capterra.normalize([
             [
               [
                 {'tags', 'Bugs & Issue Tracking,Development Tools'},
                 {'name', 'GitGHub'},
                 {'twitter', 'github'}
               ],
               [
                 {'tags', 'Instant Messaging & Chat,Web Collaboration,Productivity'},
                 {'name', 'Slack'},
                 {'twitter', 'slackhq'}
               ],
               [
                 {'tags', 'Project Management,Project Collaboration,Development Tools'},
                 {'name', 'JIRA Software'},
                 {'twitter', 'jira'}
               ]
             ]
           ]) ==
             {:ok,
              [
                %{
                  categories: ["Bugs & Issue Tracking", "Development Tools"],
                  name: "GitGHub",
                  twitter: "@github"
                },
                %{
                  categories: ["Instant Messaging & Chat", "Web Collaboration", "Productivity"],
                  name: "Slack",
                  twitter: "@slackhq"
                },
                %{
                  categories: ["Project Management", "Project Collaboration", "Development Tools"],
                  name: "JIRA Software",
                  twitter: "@jira"
                }
              ]}
  end
end
