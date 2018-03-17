defmodule Saasy do
  @moduledoc """
  Documentation for Saasy.
  """
  alias Saasy.{Parser, Normalizer}

  @feeds_folder Application.get_env(:saasy, :feeds_folder)

  @doc "Gets the configured folder where the saas files will be located"
  def feeds_folder, do: @feeds_folder

  @doc """
  """
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

        e ->
          e
      end
    end)
  end
end
