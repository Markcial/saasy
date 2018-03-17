defmodule Saasy do
  @moduledoc """
  #{File.stream!("README.md") |> Enum.drop(1) |> Enum.join("\n")}
  """
  alias Saasy.{Parser, Normalizer}

  @feeds_folder Application.get_env(:saasy, :feeds_folder)

  @doc "Gets the configured folder where the saas files will be located"
  @spec feeds_folder() :: String.t()
  def feeds_folder, do: @feeds_folder

  @doc """
  Converts service to a data structure via the required parser and the
  necessary normalizer.
  """
  @spec import(String.t()) :: List.t()
  def import(service) do
    "#{feeds_folder()}/#{service}.{yaml,json}"
    |> Path.wildcard()
    |> Enum.map(fn file ->
      parsed = Parser.load!(file)
      get_normalizer_and_apply(service, parsed)
    end)
  end

  defp get_normalizer_and_apply(service, parsed) do
    case Normalizer.get(service) do
      {:ok, s} ->
        case apply(s, :normalize, [parsed]) do
          {:ok, data} -> data
          e -> e
        end

      e = {:error, _} ->
        e
    end
  end
end
