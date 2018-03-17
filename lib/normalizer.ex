defmodule Saasy.Normalizer do
  @callback normalize_item(List.t() | Keyword.t()) :: {:ok, Map.t()} | {:error, String.t()}
  @callback normalize_collection(List.t() | Keyword.t()) :: {:ok, List.t()} | {:error, String.t()}

  defmacro __using__(_) do
    quote do
      @doc """
      Normalize abstract function.
      Calls the submodule functions so it normalizes
      data by its own submodule conventions.
      """
      @spec normalize(List.t | Keyword.t | Map.t) :: {:ok, List.t} | {:error, String.t}
      def normalize(data) do
        col =
          case normalize_collection(data) do
            {:ok, col} ->
              col
              |> Enum.map(fn itm ->
                case normalize_item(itm) do
                  {:ok, i} -> i
                  e -> e
                end
              end)

            e ->
              e
          end

        {:ok, col}
      end
    end
  end

  @doc """
  Normalizes a twitter handle username.
  The function is completely safe, there is no need for error checking.
  """
  @spec twitter_handle(String.t) :: String.t
  def twitter_handle(account = <<"@">> <> _), do: String.downcase(account)
  def twitter_handle(account), do: "@#{String.downcase(account)}"

  @doc """
  Retrieves normalizer by name. If there is no module defined by that name, returns an error.
  """
  @spec get(String.t) :: {:ok, atom()} | {:error, String.t}
  def get(name) do
    mod = Module.concat(__MODULE__, name |> String.capitalize())

    case Code.ensure_compiled?(mod) do
      true -> {:ok, mod}
      _ -> {:error, "Normalizer #{name} was not found on the library."}
    end
  end

  @doc """
  Imperative version of the `#{__MODULE__}.get` function.
  """
  @spec get!(String.t) :: atom()
  def get!(name) do
    case get(name) do
      {:ok, s} -> s
      e -> e
    end
  end
end
