defmodule Saasy do
  @moduledoc """
  #{File.stream!("README.md") |> Enum.drop(1) |> Enum.join("\n")}
  """
  alias Saasy.{Parser, Normalizer}

  @feeds_folder Application.get_env(:saasy, :feeds_folder)

  @doc "Gets the configured folder where the saas files will be located"
  @spec feeds_folder() :: String.t
  def feeds_folder, do: @feeds_folder

  @doc """
  Converts service to a data structure via the required parser and the
  necessary normalizer.
  """
  @spec import(String.t) :: List.t
  def import(service) do
    Path.wildcard("#{feeds_folder()}/#{service}.{yaml,json}")
    |> Enum.map(fn doc ->
      parsed = Parser.parse!(doc)
      case Normalizer.get(service) do
        {:ok, s} ->
          case apply(s, :normalize, [parsed]) do
            {:ok, data} -> data
            e -> e
          end
        e = {:error, _} -> e
      end
    end)
  end
end
