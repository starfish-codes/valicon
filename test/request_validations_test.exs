defmodule RequestValidationsTest do
  use ExUnit.Case, async: true
  alias RequestValidations.ValidationError

  import RequestValidations

  @attrs %{
    name: "Butterfree",
    number: "012",
    hp: 60,
    speed: 70,
    attack: 45,
    defense: 50,
    special_attack: 90,
    special_defense: 80,
    mod: "",
    types: ["bug", "flying"],
    is_mega: false
  }

  describe "validate/2" do
    test "empty validations list returns success" do
      assert {:ok, @attrs} = validate(@attrs, [])
    end

    test "accamulation of validation errors" do
      assert {:error,
              [
                %ValidationError{path: "hp", message: "message 3"},
                %ValidationError{path: "name", message: "message 1"},
                %ValidationError{path: "number", message: "message 2"}
              ]} ==
               validate(@attrs, [
                 fn _attrs ->
                   [
                     ValidationError.new("name", "message 1"),
                     ValidationError.new("number", "message 2")
                   ]
                 end,
                 fn _attrs -> ValidationError.new("hp", "message 3") end
               ])
    end

    test "returns success when validation functions return empty lists" do
      assert {:ok, @attrs} =
               validate(@attrs, [
                 fn _attrs -> [] end,
                 fn _attrs -> [] end
               ])
    end
  end
end
