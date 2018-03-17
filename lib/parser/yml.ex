defmodule Saasy.Parser.Yml do
  use Saasy.Parser,
    engine: :yamerl_constr,
    ep: :string
end
