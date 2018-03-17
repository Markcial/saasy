defmodule Saasy.Parser.Yml do
  @moduledoc """
  Yaml parser bridge, uses the [yamerl](https://github.com/yakaz/yamerl) engine
  """
  use Saasy.Parser,
    engine: :yamerl_constr,
    ep: :string
end
