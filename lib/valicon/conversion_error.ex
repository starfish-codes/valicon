defmodule Valicon.ConversionError do
  defstruct ~w[message path]a

  @type t() :: %__MODULE__{
          message: String.t(),
          path: String.t()
        }

  @spec new(String.t(), String.t()) :: t()
  def new(path, message),
    do: %__MODULE__{message: message, path: path}
end
