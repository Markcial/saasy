defmodule Saasy.Parser.Json do
  @moduledoc """
  Json parser bridge, uses the [Jason](https://hexdocs.pm/jason/readme.html) engine
  """
  use Saasy.Parser, engine: Jason
end
