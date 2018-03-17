defmodule Saasy.Normalizer.Capterra do
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

  """
  def normalize_collection(data) do
    try do
      {:ok, get_in(data, [Access.at(0)])}
    rescue
      e -> {:error, e}
    end
  end
end
