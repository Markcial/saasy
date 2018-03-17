defmodule Saasy.Parser do
  @moduledoc """
  Abstract class for every parser that the loader might be able to need
  """

  @doc """
  Makes this module extendable so the other parsers can acquire the parse method
  Due to different implementations of the several parsers this function is done with
  a try catch block so even with different implementations we can be sure that
  this function is safe from exceptions
  """
  defmacro __using__(opts \\ []) do
    engine = Keyword.get(opts, :engine)
    ep = Keyword.get(opts, :ep, :decode)

    quote do
      @doc """
      Parses the text with the engine provided in the use call.
      """
      def parse(text) do
        try do
          case apply(unquote(engine), unquote(ep), [text]) do
            s = {:ok, parsed} -> s
            s -> {:ok, s}
          end
        rescue
          e -> e
        end
      end

      @doc """
      Imperative method for parseing the source with the engine provided by the module configuration.
      """
      def parse!(text) do
        case parse(text) do
          {:ok, parsed} -> parsed
          e = {:error, _} -> raise e
        end
      end
    end
  end

  @doc """
  Gets data parser by extension without side effects
  """
  def get(filename) do
    case Path.extname(filename) do
      ".yml" -> {:ok, Saasy.Parser.Yml}
      ".yaml" -> {:ok, Saasy.Parser.Yml}
      ".json" -> {:ok, Saasy.Parser.Json}
      _ -> {:error, "Not Implemented!"}
    end
  end

  @doc """
  Retrieves the data parser in an imperative style
  """
  def get!(filename) do
    case get(filename) do
      {:ok, parser} -> parser
      {:error, error} -> raise error
    end
  end

  @doc """
  Reads content from a file and converts it to a data structure
  """
  def parse(filename) do
    case File.read(filename) do
      {:ok, contents} ->
        case get(filename) do
          {:ok, parser} -> apply(parser, :parse, [contents])
          e = {:error, _} -> e
        end

      e = {:error, _} ->
        e
    end
  end

  @doc """
  Imperative style of the parse method
  """
  def parse!(filename) do
    case parse(filename) do
      {:ok, parsed} -> parsed
      e = {:err, _} -> raise e
    end
  end
end
