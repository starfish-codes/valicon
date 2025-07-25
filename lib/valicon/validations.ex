defmodule Valicon.Validations do
  @moduledoc """
    The different validations that can be applied to the attributes.
  """
  alias Valicon.ValidationError

  @uuid_regex ~r"^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$"i

  @spec validate_required_fields(map(), [Valicon.key()], String.t()) :: [ValidationError.t()]
  def validate_required_fields(attrs, keys, prefix \\ "") do
    keys
    |> Enum.reject(fn key -> Map.has_key?(attrs, key) end)
    |> Enum.map(fn missing_key ->
      ValidationError.new("#{prefix}#{missing_key}", "#{missing_key} is required")
    end)
  end

  @spec validate_string_fields(map(), [Valicon.key()], String.t()) :: [ValidationError.t()]
  def validate_string_fields(attrs, keys, prefix \\ "") do
    Enum.reduce(keys, [], fn key, acc ->
      validate_string("#{prefix}#{key}", Map.get(attrs, key)) ++ acc
    end)
  end

  @spec validate_base64_url_fields(map(), [Valicon.key()], String.t()) :: [ValidationError.t()]
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

  @spec validate_not_nullable_fields(map(), [Valicon.key()], String.t()) :: [ValidationError.t()]
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

  @spec validate_list(map(), Valicon.key(), [atom()], String.t()) :: [ValidationError.t()]
  @spec validate_list(map(), Valicon.key(), [String.t()], String.t()) :: [ValidationError.t()]
  def validate_list(attrs, key, allowed, prefix \\ "") do
    attrs
    |> Map.get(key, [])
    |> Stream.uniq()
    |> Stream.filter(fn val -> val not in allowed end)
    |> Enum.map(fn invalid_val ->
      ValidationError.new("#{prefix}#{key}", "#{key} #{invalid_val} is not allowed")
    end)
  end

  @spec validate_enum(map(), Valicon.key(), list(), String.t()) :: [ValidationError.t()]
  def validate_enum(attrs, key, allowed, prefix \\ "") do
    case Map.fetch(attrs, key) do
      {:ok, nil} ->
        []

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

  @spec validate_datetime_fields(map(), [Valicon.key()], String.t()) :: [ValidationError.t()]
  def validate_datetime_fields(attrs, keys, prefix \\ "") do
    Enum.reduce(keys, [], fn key, acc ->
      validate_datetime("#{prefix}#{key}", Map.get(attrs, key)) ++ acc
    end)
  end

  @spec validate_datetime(Valicon.key(), nil | String.t()) :: [ValidationError.t()]
  def validate_datetime(_key, nil), do: []

  def validate_datetime(_key, value) when is_struct(value, DateTime), do: []

  def validate_datetime(key, value) when is_binary(value) do
    case DateTime.from_iso8601(value) do
      {:ok, _datetime, _offset} -> []
      {:error, error} -> [ValidationError.new(key, "is not a valid datetime: #{error}")]
    end
  end

  def validate_datetime(key, _value) do
    [ValidationError.new(key, "must be a string following the datetime standard from ISO 8601")]
  end

  @spec validate_integer_fields(map(), list(atom())) :: [ValidationError.t()]
  @spec validate_integer_fields(map(), list(atom()), String.t()) :: [ValidationError.t()]
  def validate_integer_fields(attrs, keys, prefix \\ "") do
    Enum.reduce(keys, [], fn key, acc ->
      validate_integer("#{prefix}#{key}", Map.get(attrs, key)) ++ acc
    end)
  end

  defp validate_integer(_key, nil), do: []

  defp validate_integer(key, value) when not is_integer(value),
    do: [ValidationError.new("#{key}", "#{key} must be an integer")]

  defp validate_integer(_key, _value), do: []

  @spec validate_url_fields(map(), [Valicon.key()], String.t()) :: [ValidationError.t()]
  def validate_url_fields(attrs, keys, prefix \\ "") do
    Enum.reduce(keys, [], fn key, acc ->
      validate_url(attrs, key, prefix) ++ acc
    end)
  end

  @spec validate_url(map(), Valicon.key(), String.t()) :: [ValidationError.t()]
  def validate_url(attrs, key, prefix \\ "") do
    case Map.fetch(attrs, key) do
      {:ok, value} when not is_nil(value) -> validate_url_value(value, "#{prefix}#{key}")
      {:ok, nil} -> []
      :error -> []
    end
  end

  defp validate_url_value(url, key) when is_binary(url) do
    case URI.parse(url) do
      %URI{scheme: scheme} when not is_nil(scheme) ->
        []

      %URI{} ->
        [ValidationError.new("#{key}", "Invalid URL")]
    end
  end

  defp validate_url_value(_url, key), do: [ValidationError.new("#{key}", "URL must be a string")]

  @spec validate_range(map(), Valicon.key(), integer(), integer(), String.t()) :: [
          ValidationError.t()
        ]
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

  @spec validate_less_than_or_equal_to(map(), Valicon.key(), integer(), String.t()) :: [
          ValidationError.t()
        ]
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
    do: [ValidationError.new("#{key}", "Cannot be empty")]

  defp validate_string(key, value) when is_list(value),
    do: [ValidationError.new("#{key}", "Cannot be a list")]

  defp validate_string(key, value) when not is_binary(value),
    do: [ValidationError.new("#{key}", "#{key} must be a string")]

  defp validate_string(_key, _value), do: []

  @spec validate_uuid_fields(map(), [atom()]) :: [ValidationError.t()]
  def validate_uuid_fields(attrs, keys, prefix \\ "") do
    Enum.reduce(keys, [], fn key, acc ->
      validate_uuid("#{prefix}#{key}", Map.get(attrs, key)) ++ acc
    end)
  end

  @spec validate_boolean_fields(map(), [atom()]) :: [ValidationError.t()]
  def validate_boolean_fields(attrs, keys, prefix \\ "") do
    Enum.reduce(keys, [], fn key, acc ->
      case Map.fetch(attrs, key) do
        {:ok, value} -> validate_boolean("#{prefix}#{key}", value) ++ acc
        :error -> acc
      end
    end)
  end

  defp validate_boolean(_key, nil), do: []
  defp validate_boolean(_key, true), do: []
  defp validate_boolean(_key, false), do: []

  defp validate_boolean(key, value),
    do: [ValidationError.new("#{key}", "#{key} must be a boolean (value: #{value})")]

  defp validate_uuid(_key, nil), do: []

  defp validate_uuid(key, value) when not is_binary(value),
    do: [ValidationError.new("#{key}", "#{key} must be a UUID")]

  defp validate_uuid(key, value) do
    if String.match?(value, @uuid_regex) do
      []
    else
      [
        ValidationError.new(
          "#{key}",
          "#{key} must be a UUID"
        )
      ]
    end
  end

  @spec validate_fqdn(map(), Valicon.key(), String.t()) :: [ValidationError.t()]
  def validate_fqdn(attrs, key, prefix \\ "") do
    case Map.fetch(attrs, key) do
      {:ok, value} -> validate_fqdn_value(value, key, prefix)
      :error -> []
    end
  end

  defp validate_fqdn_value(nil, _key, _prefix), do: []

  defp validate_fqdn_value(value, key, prefix) do
    if fqdn_valid?(value) do
      []
    else
      [ValidationError.new("#{prefix}#{key}", "Domain must be a valid FQDN")]
    end
  end

  @spec fqdn_valid?(String.t()) :: boolean()
  def fqdn_valid?(fqdn), do: fqdn_valid_length?(fqdn) && fqdn_valid_labels?(fqdn)

  defp fqdn_valid_length?(fqdn), do: String.length(fqdn) <= 253

  defp fqdn_valid_labels?(fqdn) when is_binary(fqdn) do
    fqdn
    |> String.split(".")
    |> Enum.reverse()
    |> case do
      [""] -> false
      [tld | labels] -> fqdn_valid_tld?(tld) && fqdn_valid_labels?(labels)
    end
  end

  defp fqdn_valid_labels?([]), do: false

  defp fqdn_valid_labels?(labels) when is_list(labels),
    do: Enum.all?(labels, &fqdn_valid_label?/1)

  defp fqdn_valid_label?(label) do
    !String.starts_with?(label, "-") && !String.ends_with?(label, "-") &&
      String.match?(label, ~r/^[[:alnum:]-]{1,63}$/)
  end

  defp fqdn_valid_tld?(tld), do: String.match?(tld, ~r/^[[:alpha:]]{2,63}$/)

  @spec validate_length(map(), list(), integer(), integer(), String.t()) :: [ValidationError.t()]
  def validate_length(attrs, keys, min_len, max_len, prefix \\ "")

  def validate_length(attrs, keys, min_len, max_len, prefix) when is_list(keys) do
    Enum.reduce(keys, [], fn key, acc ->
      do_validate_length(key, Map.get(attrs, key), min_len, max_len, prefix) ++ acc
    end)
  end

  defp do_validate_length(key, value, min_len, max_len, prefix) when is_binary(value) do
    length = String.length(value)

    message =
      "#{prefix}#{key} length must be greater than or equal to #{min_len} and less than or equal to #{max_len}"

    if length < min_len or length > max_len,
      do: [ValidationError.new("#{prefix}#{key}", message)],
      else: []
  end

  defp do_validate_length(_key, _value, _min_len, _max_len, _prefix), do: []
end
