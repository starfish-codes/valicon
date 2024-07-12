defmodule Valicon do
  @moduledoc """
    The collection of ectoless validation and helper functions for validation
    of pure data structures.
  """
  alias Valicon.ValidationError

  defmacro __using__(_opts) do
    quote do
      import Valicon.{Conversions, Validations}
      import Valicon
    end
  end

  @doc """
    Validates the given attributes with the given validations.
  """
  @spec validate(map() | list(), [(map() | list() -> [ValidationError.t()] | ValidationError.t())]) ::
          {:ok, map() | list()} | {:error, [ValidationError.t()]}
  def validate(attrs, validations) do
    case run_validations(attrs, validations) do
      [] ->
        {:ok, attrs}

      validation_errors ->
        {:error, validation_errors}
    end
  end

  @doc """
    Runs the given validations on the given attributes.
  """
  @spec run_validations(map() | list(), [
          (map() | list() -> [ValidationError.t()] | ValidationError.t())
        ]) :: [
          ValidationError.t()
        ]
  def run_validations(attrs, validations) do
    Enum.reduce(validations, [], fn validation_fun, acc ->
      List.wrap(validation_fun.(attrs)) ++ acc
    end)
  end
end
