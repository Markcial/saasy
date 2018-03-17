defmodule Saasy.Normalizer.Capterra do
  @moduledoc """
  Nomalizer used to transform data by the convetion defined by capterra.
  """
  alias Saasy.Normalizer
  @behaviour Normalizer
  use Normalizer

  @doc """
  Normalizes a single item by the convention stablished with capterra.
  """
  @spec normalize_item(List.t() | Keyword.t() | Map.t()) :: {:ok, List.t()} | {:error, String.t()}
  def normalize_item(itm) do
    try do
      out =
        itm
        |> Enum.map(fn
          {'tags', t} ->
            {:categories, t |> List.to_string() |> String.split(",")}

          {'twitter', t} ->
            {:twitter, Normalizer.twitter_handle(t |> List.to_string())}

          {prefix, name} ->
            {
              prefix |> List.to_string() |> String.to_atom(),
              name |> List.to_string()
            }
        end)
        |> Enum.into(%{})

      {:ok, out}
    rescue
      e -> {:error, e}
    end
  end

  @doc """
  Normalizes the collection by the convention stablished with capterra.
  """
  @spec normalize_collection(List.t() | Keyword.t() | Map.t()) ::
          {:ok, List.t()} | {:error, String.t()}
  def normalize_collection(data) do
    try do
      {:ok, get_in(data, [Access.at(0)])}
    rescue
      e -> {:error, e}
    end
  end
end
