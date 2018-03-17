defmodule Saasy.Normalizer.Softwareadvice do
  @moduledoc """

  """
  alias Saasy.Normalizer
  @behaviour Normalizer
  use Normalizer

  @doc """

  """
  def normalize_item(itm) do
    try do
      out =
        itm
        |> Enum.map(fn
          {'title', t} -> {:name, t}
          {prefix, name} -> {prefix |> String.to_atom(), name}
        end)
        |> Enum.into(%{})

      {:ok, out}
    rescue
      e -> {:error, e}
    end
  end

  @doc """

  """
  def normalize_collection(data) do
    try do
      {:ok, get_in(data, ["products"])}
    rescue
      e -> {:error, e}
    end
  end
end
