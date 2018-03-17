defmodule Saasy.Loader do

  defmacro __using__(opts \\ []) do
    engine = Keyword.get(opts, :engine)
    ep = Keyword.get(opts, :ep, :"decode!")
    quote do
      def parse(text) do
        apply(
          unquote(engine),
          unquote(ep),
          [text]
        )
      end
    end
  end
end
