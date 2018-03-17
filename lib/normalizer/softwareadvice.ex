defmodule Saasy.Normalizer.Softwareadvice do
  @moduledoc """
  Nomalizer used to transform data by the convetion defined by softwareadvice.
  """
  alias Saasy.Normalizer
  @behaviour Normalizer
  use Normalizer

  @doc """
  Normalizes a single item by the convention stablished with softwareadvice.
  """
  @spec normalize_item(List.t() | Keyword.t() | Map.t()) ::
          {:ok, Keyword.t()} | {:error, String.t()}
  def normalize_item(itm) do
    try do
      out =
        itm
        |> Enum.map(fn
          {"title", t} -> {:name, t}
          {prefix, name} -> {prefix |> String.to_atom(), name}
        end)
        |> Enum.into(%{})

      {:ok, out}
    rescue
      e -> {:error, e}
    end
  end

  @doc """
  Normalizes the collection by the convention stablished with softwareadvice.
  """
  @spec normalize_collection(List.t() | Keyword.t() | Map.t()) ::
          {:ok, List.t()} | {:error, String.t()}
  def normalize_collection(data) do
    try do
      {:ok, get_in(data, ["products"])}
    rescue
      e -> {:error, e}
    end
  end
end
