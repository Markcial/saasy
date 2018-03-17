defmodule Saasy.Cli do
  @moduledoc """
  Terminal endpoint for saasy import library
  """
  require Logger
  require OptionParser

  @help """
  Command: saasy #{Mix.Project.config()[:version]} --provider [PROVIDER].
  Description
  -----------
  Command that integrates data from different services. Converts their files with data to a native elixir format.
  --------------------------
  Usage
  -----
    --provider: Name of the provider to import. Available ones are: capterra, softwareadvice
  """

  def main(args) do
    args |> parse_args |> execute
  end

  def parse_args(args) do
    {options, _, _} = OptionParser.parse(args, switches: [provider: :string])
    options
  end

  defp show_pair({k, v}) when is_list(v), do: show_pair({k, v |> Enum.join(", ")})

  defp show_pair({k, v}) do
    "#{String.capitalize(k |> Atom.to_string())}: #{v}"
  end

  defp show(item) do
    item
    |> Enum.map(fn item ->
      item
      |> Enum.map(&show_pair/1)
      |> Enum.join("; ")
    end)
    |> Enum.map(fn x ->
      IO.puts("Importing #{x}")
    end)
  end

  def execute([]) do
    IO.puts("""
    Missing required argument
    #{@help}
    """)
  end

  def execute(provider: provider) do
    provider
    |> Saasy.import()
    |> Enum.each(&show/1)
  end
end
