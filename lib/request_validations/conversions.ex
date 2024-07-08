defmodule RequestValidations.Conversions do
  @moduledoc """
    Data transformation functions. Pretty generic but used mostly before calling the validations.
  """
  alias RequestValidations.ConversionError

  @doc """
    Casts the string values inside the attrs map to the given types.
    
    ## Examples
    
        iex> cast(%{name: "Butterfree", number: "012"}, [name: :string, number: :integer])
        {:ok, %{name: "Butterfree", number: 12}}
  """
  @spec cast(map(), Keyword.t()) :: {:ok, map()} | {:error, [ConversionError.t()]}
  def cast(attrs, fields), do: cast(attrs, fields, [])

  defp cast(attrs, [], []), do: {:ok, attrs}
  defp cast(_attrs, [], errors), do: {:error, errors}

  defp cast(attrs, [{key, type} | rest], errors) do
    case cast_one(attrs, key, type) do
      {:ok, new_attrs} -> cast(new_attrs, rest, errors)
      {:error, error} -> cast(attrs, rest, [error | errors])
    end
  end

  defp cast_one(attrs, key, type) do
    case Map.fetch(attrs, key) do
      {:ok, value} -> cast_one(attrs, key, value, type)
      :error -> {:ok, attrs}
    end
  end

  defp cast_one(attrs, key, value, type) do
    case parse(value, type) do
      {:ok, result} -> {:ok, Map.put(attrs, key, result)}
      {:error, _reason} -> {:error, convertion_error(key, type)}
    end
  end

  @spec parse(String.t(), :date) :: {:ok, Date.t()} | {:error, atom()}
  @spec parse(String.t(), :integer) :: {:ok, integer()} | {:error, :bad_integer}
  @spec parse(String.t(), :boolean) :: {:ok, boolean()} | {:error, :bad_boolean}
  @spec parse(String.t() | [String.t()], :list) :: {:ok, [String.t()]}
  @spec parse(String.t(), :string) :: {:ok, String.t()}
  def parse(value, :date), do: Date.from_iso8601(value)
  def parse(value, :integer), do: parse_integer(value)
  def parse(value, :float), do: parse_float(value)
  def parse(value, :boolean), do: parse_boolean(value)
  def parse(value, :list), do: parse_list(value)
  def parse(value, :string), do: parse_string(value)

  @spec parse_string(term()) :: {:ok, String.t()} | {:error, :bad_string}
  def parse_string(value) when is_binary(value), do: {:ok, value}
  def parse_string(_value), do: {:error, :bad_string}
  @spec parse_integer(term()) :: {:ok, integer()} | {:error, :bad_integer}
  def parse_integer(value) do
    case Integer.parse(value) do
      {value, ""} -> {:ok, value}
      _error -> {:error, :bad_integer}
    end
  end

  @spec parse_float(term()) :: {:ok, float()} | {:error, :bad_float}
  def parse_float(value) do
    case Float.parse(value) do
      {value, ""} -> {:ok, value}
      _error -> {:error, :bad_float}
    end
  end

  @spec parse_boolean(term()) :: {:ok, boolean()} | {:error, :bad_boolean}
  def parse_boolean("true"), do: {:ok, true}
  def parse_boolean("false"), do: {:ok, false}
  def parse_boolean(_unexpeted), do: {:error, :bad_boolean}

  @spec parse_list(String.t() | [String.t()]) :: {:ok, [String.t()]} | {:error, :bad_list}
  def parse_list(list) when is_list(list), do: {:ok, list}
  def parse_list(val) when is_binary(val), do: {:ok, String.split(val, ",")}
  def parse_list(_unexpected), do: {:error, :bad_list}

  defp convertion_error(key, type),
    do: ConversionError.new("#{key}", "#{key} must be a value of #{type} type")

  @spec atomize_keys(map(), [atom()]) :: map()
  def atomize_keys(attrs, keys) do
    Enum.reduce(keys, %{}, fn atom_key, acc ->
      string_key = Atom.to_string(atom_key)

      case Map.fetch(attrs, string_key) do
        {:ok, value} -> Map.put(acc, atom_key, value)
        :error -> acc
      end
    end)
  end

  @spec trim_whitespaces(any()) :: any()
  def trim_whitespaces(input) when is_map(input),
    do: Enum.into(input, %{}, fn {k, v} -> {k, trim_whitespaces(v)} end)

  def trim_whitespaces(input) when is_binary(input), do: String.trim(input)
  def trim_whitespaces(input), do: input

  @spec upcase_in(map(), atom()) :: map()
  def upcase_in(attrs, key), do: transform_in(attrs, key, &String.upcase/1)

  @spec downcase_in(map(), atom()) :: map()
  def downcase_in(attrs, key), do: transform_in(attrs, key, &String.downcase/1)

  @spec transform(map(), list()) :: map()
  def transform(attrs, fields) do
    for {original_key, new_key} <- fields, reduce: %{} do
      acc ->
        Map.put(acc, new_key, Map.get(attrs, original_key))
    end
  end

  @spec transform_in(map(), atom(), (term() -> term())) :: map()
  def transform_in(attrs, key, transformation) do
    case Map.fetch(attrs, key) do
      {:ok, value} when is_map(value) ->
        Map.put(attrs, key, transformation.(value))

      {:ok, value} when is_binary(value) ->
        Map.put(attrs, key, transformation.(value))

      {:ok, list} when is_list(list) ->
        Map.put(attrs, key, Enum.map(list, transformation))

      _else ->
        attrs
    end
  end
end
