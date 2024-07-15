defmodule Valicon.Validations do
  @moduledoc """
    The different validations that can be applied to the attributes.
  """
  alias Valicon.ValidationError

  @spec validate_required_fields(map(), [atom()], String.t()) :: [ValidationError.t()]
  def validate_required_fields(attrs, keys, prefix \\ "") do
    keys
    |> Enum.reject(fn key -> Map.has_key?(attrs, key) end)
    |> Enum.map(fn missing_key ->
      ValidationError.new("#{prefix}#{missing_key}", "#{missing_key} is required")
    end)
  end

  @spec validate_string_fields(map(), [atom()], String.t()) :: [ValidationError.t()]
  def validate_string_fields(attrs, keys, prefix \\ "") do
    Enum.reduce(keys, [], fn key, acc ->
      validate_string("#{prefix}#{key}", Map.get(attrs, key)) ++ acc
    end)
  end

  @spec validate_base64_url_fields(map(), [atom()], String.t()) :: [ValidationError.t()]
  def validate_base64_url_fields(attrs, keys, prefix \\ "") do
    Enum.reduce(keys, [], fn key, acc ->
      validate_base64_url("#{prefix}#{key}", Map.get(attrs, key)) ++ acc
    end)
  end

  defp validate_base64_url(key, value) when not is_binary(value) do
    [ValidationError.new("#{key}", "the value is not base64 decodable")]
  end

  defp validate_base64_url(key, value) do
    case Base.url_decode64(value, padding: false) do
      :error ->
        [ValidationError.new("#{key}", "the value is not base64 decodable")]

      {:ok, _value} ->
        []
    end
  end

  @spec validate_not_nullable_fields(map(), [atom()], String.t()) :: [ValidationError.t()]
  def validate_not_nullable_fields(attrs, keys, prefix \\ "") do
    keys
    |> Enum.filter(fn key -> nulled_key?(attrs, key) end)
    |> Enum.map(fn violating_key ->
      ValidationError.new(
        "#{prefix}#{violating_key}",
        "#{prefix}#{violating_key} is required and must not be set to null"
      )
    end)
  end

  defp nulled_key?(attrs, key),
    do: Map.has_key?(attrs, key) && Map.get(attrs, key) == nil

  @spec validate_list(map(), atom(), [String.t()], String.t()) :: [ValidationError.t()]
  def validate_list(attrs, key, allowed, prefix \\ "") do
    attrs
    |> Map.get(key, [])
    |> Stream.uniq()
    |> Stream.filter(fn val -> val not in allowed end)
    |> Enum.map(fn invalid_val ->
      ValidationError.new("#{prefix}#{key}", "#{key} #{invalid_val} is not allowed")
    end)
  end

  @spec validate_enum(map(), atom(), list(), String.t()) :: [ValidationError.t()]
  def validate_enum(attrs, key, allowed, prefix \\ "") do
    case Map.fetch(attrs, key) do
      {:ok, value} ->
        validate_enum_value(value, allowed, key, prefix)

      :error ->
        []
    end
  end

  defp validate_enum_value(value, allowed, key, prefix) do
    if value in allowed do
      []
    else
      allowed_values = Enum.join(allowed, ", ")

      [
        ValidationError.new(
          "#{prefix}#{key}",
          "#{prefix}#{key} must be one of the following: #{allowed_values}"
        )
      ]
    end
  end

  @spec validate_url(map, atom) :: [ValidationError.t()]
  def validate_url(attrs, key) do
    case Map.fetch(attrs, key) do
      {:ok, value} when not is_nil(value) -> validate_url_value(value, key)
      {:ok, nil} -> []
      :error -> []
    end
  end

  defp validate_url_value(url, key) do
    case URI.parse(url) do
      %URI{scheme: scheme} when not is_nil(scheme) ->
        []

      %URI{} ->
        [ValidationError.new("#{key}", "Invalid URL")]
    end
  end

  @spec validate_range(map, atom, integer, integer, String.t()) :: [ValidationError.t()]
  def validate_range(attrs, key, from, to, prefix \\ "") do
    Valicon.run_validations(attrs, [
      &validate_greater_than_or_equal_to(&1, key, from, prefix),
      &validate_less_than_or_equal_to(&1, key, to, prefix)
    ])
  end

  @spec validate_greater_than_or_equal_to(map, atom, integer, String.t()) :: [ValidationError.t()]
  def validate_greater_than_or_equal_to(attrs, key, limit, prefix \\ "") do
    case Map.fetch(attrs, key) do
      {:ok, value} when value < limit ->
        [
          ValidationError.new(
            "#{prefix}#{key}",
            "#{key} must be greater than or equal to #{limit}"
          )
        ]

      {:ok, _value} ->
        []

      :error ->
        []
    end
  end

  @spec validate_less_than_or_equal_to(map, atom, integer, String.t()) :: [ValidationError.t()]
  def validate_less_than_or_equal_to(attrs, key, limit, prefix \\ "") do
    case Map.fetch(attrs, key) do
      {:ok, value} when value > limit ->
        [ValidationError.new("#{prefix}#{key}", "#{key} must be less than or equal to #{limit}")]

      {:ok, _value} ->
        []

      :error ->
        []
    end
  end

  defp validate_string(_key, nil), do: []

  defp validate_string(key, ""),
    do: [ValidationError.new("#{key}", "Can not be empty")]

  defp validate_string(key, value) when is_list(value),
    do: [ValidationError.new("#{key}", "Can not be a list")]

  defp validate_string(key, value) when not is_binary(value),
    do: [ValidationError.new("#{key}", "#{key} must be a string")]

  defp validate_string(_key, _value), do: []

  @spec validate_uuid_fields(map(), [atom()]) :: [ValidationError.t()]
  def validate_uuid_fields(attrs, keys) do
    Enum.reduce(keys, [], fn key, acc ->
      validate_uuid(key, Map.get(attrs, key)) ++ acc
    end)
  end

  @spec validate_boolean_fields(map(), [atom()]) :: [ValidationError.t()]
  def validate_boolean_fields(attrs, keys) do
    Enum.reduce(keys, [], fn key, acc ->
      case Map.fetch(attrs, key) do
        {:ok, value} -> validate_boolean(key, value) ++ acc
        :error -> acc
      end
    end)
  end

  defp validate_boolean(_key, true), do: []
  defp validate_boolean(_key, false), do: []

  defp validate_boolean(key, value),
    do: [ValidationError.new("#{key}", "#{key} must be a boolean (value: #{value})")]

  defp validate_uuid(_key, nil), do: []

  defp validate_uuid(key, value) when not is_binary(value),
    do: [ValidationError.new("#{key}", "#{key} must be a UUID (value: #{value})")]

  defp validate_uuid(key, value) do
    if String.match?(
         value,
         ~r"^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$"i
       ) do
      []
    else
      [
        ValidationError.new(
          "#{key}",
          "#{key} must be a UUID (value: #{value})"
        )
      ]
    end
  end
end
