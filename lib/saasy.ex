defmodule Saasy do
  @moduledoc """
  Documentation for Saasy.
  """

  @feeds_folder Application.get_env(:saasy, :feeds_folder)

  @doc "Gets the configured folder where the saas files will be located"
  def feeds_folder, do: @feeds_folder

  @doc """
  Gets data loader by extension without side effects
  """
  def get_loader(filename) do
    case Path.extname(filename) do
      ".yml" -> {:ok, Saasy.Loader.Yml}
      ".yaml" -> {:ok, Saasy.Loader.Yml}
      ".json" -> {:ok, Saasy.Loader.Json}
      _ -> {:error, "Not Implemented!"}
    end
  end

  @doc """
  Retrieves the data loader in an imperative style
  """
  def get_loader!(filename) do
    case get_loader(filename) do
      {:ok, loader} -> loader
      {:error, error} -> raise error
    end
  end
end
