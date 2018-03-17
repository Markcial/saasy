defmodule Saasy.Parser.Yml do
  @moduledoc """
  """
  use Saasy.Parser,
    engine: :yamerl_constr,
    ep: :string
end
