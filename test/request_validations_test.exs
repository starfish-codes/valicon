defmodule RequestValidationsTest do
  use ExUnit.Case
  doctest RequestValidations

  test "greets the world" do
    assert RequestValidations.hello() == :world
  end
end
