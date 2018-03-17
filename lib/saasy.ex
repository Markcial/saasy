defmodule Saasy do
  @moduledoc """
  Documentation for Saasy.
  """
  alias Saasy.Parser

  @feeds_folder Application.get_env(:saasy, :feeds_folder)

  @doc "Gets the configured folder where the saas files will be located"
  def feeds_folder, do: @feeds_folder
end
