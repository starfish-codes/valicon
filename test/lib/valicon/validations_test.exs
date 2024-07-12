defmodule Valicon.ValidationsTest do
  use ExUnit.Case, async: true
  alias Valicon.ValidationError

  import Valicon.Validations

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
    is_mega: false,
    pokedex_url_base64_encoded: "aHR0cHM6Ly93d3cucG9rZW1vbi5jb20vdXMvcG9rZWRleC9idXR0ZXJmcmVl",
    pokedex_url: "https://www.pokemon.com/us/pokedex/butterfree",
    id: Faker.UUID.v4()
  }

  describe "validate_required_fields/2" do
    test "validates required fields" do
      assert [] == validate_required_fields(@attrs, ~w[name number]a)

      assert [
               %ValidationError{path: "gender", message: "gender is required"}
             ] == validate_required_fields(@attrs, ~w[name number gender]a)
    end
  end

  describe "validate_string_fields/2" do
    test "validates string fields" do
      assert [] == validate_string_fields(@attrs, ~w[name number]a)

      assert [] == validate_string_fields(%{}, ~w[name]a)

      assert [%Valicon.ValidationError{message: "Can not be a list", path: "types"}] ==
               validate_string_fields(@attrs, ~w[types]a)

      assert [
               %ValidationError{path: "hp", message: "hp must be a string"}
             ] == validate_string_fields(@attrs, ~w[name number hp]a)

      assert [
               %ValidationError{path: "mod", message: "Can not be empty"}
             ] == validate_string_fields(@attrs, ~w[name number mod]a)
    end
  end

  describe "validate_base64_url_fields/2" do
    test "validates base64 url fields" do
      assert [] == validate_base64_url_fields(@attrs, ~w[pokedex_url_base64_encoded]a)

      assert [
               %ValidationError{
                 message: "the value is not base64 decodable",
                 path: "pokedex_url"
               }
             ] == validate_base64_url_fields(@attrs, ~w[pokedex_url]a)

      assert [
               %ValidationError{
                 message: "the value is not base64 decodable",
                 path: "hp"
               }
             ] == validate_base64_url_fields(@attrs, ~w[hp]a)
    end
  end

  describe "validate_not_nullable_fields/3" do
    test "validates not nullable fields" do
      assert [] == validate_not_nullable_fields(@attrs, ~w[name number]a)

      assert [
               %ValidationError{
                 message: "name is required and must not be set to null",
                 path: "name"
               }
             ] == validate_not_nullable_fields(%{@attrs | name: nil}, ~w[name number]a)
    end
  end

  describe "validate_list/3" do
    test "validates list fields" do
      assert [] == validate_list(@attrs, :types, ~w[bug flying])

      assert [
               %Valicon.ValidationError{
                 message: "types bug is not allowed",
                 path: "types"
               },
               %Valicon.ValidationError{
                 message: "types flying is not allowed",
                 path: "types"
               }
             ] == validate_list(@attrs, :types, ~w[grass poison])
    end
  end

  describe "validate_enum/3" do
    test "validates enum fields" do
      assert [] == validate_enum(@attrs, :hp, 50..80)

      assert [
               %ValidationError{
                 message: "hp must be one of the following: 80, 81, 82, 83",
                 path: "hp"
               }
             ] == validate_enum(@attrs, :hp, 80..83)

      assert [] == validate_enum(@attrs, :exp, 50..80)
    end
  end

  describe "validate_url/2" do
    test "validations" do
      assert [] == validate_url(%{service_url: Faker.Internet.url()}, :service_url)
      assert [] == validate_url(%{}, :service_url)

      assert [%ValidationError{message: "Invalid URL", path: "service_url"}] =
               validate_url(%{service_url: "garbage"}, :service_url)

      assert [] == validate_url(%{service_url: nil}, :service_url)
    end
  end

  describe "validate_range/4" do
    test "validates range fields" do
      assert [] == validate_range(@attrs, :hp, 50, 80)

      assert [
               %ValidationError{
                 message: "hp must be greater than or equal to 80",
                 path: "hp"
               }
             ] ==
               validate_range(@attrs, :hp, 80, 100)

      assert [
               %ValidationError{
                 message: "hp must be less than or equal to 30",
                 path: "hp"
               }
             ] ==
               validate_range(@attrs, :hp, 20, 30)
    end
  end

  describe "validate_greater_than_or_equal_to/3" do
    test "validates greater or equal to fields" do
      assert [] == validate_greater_than_or_equal_to(@attrs, :hp, 50)

      assert [
               %ValidationError{
                 message: "hp must be greater than or equal to 80",
                 path: "hp"
               }
             ] == validate_greater_than_or_equal_to(@attrs, :hp, 80)

      assert [] == validate_greater_than_or_equal_to(@attrs, :exp, 30)
    end
  end

  describe "validate_less_than_or_equal_to/3" do
    test "validates greater or equal to fields" do
      assert [] == validate_less_than_or_equal_to(@attrs, :hp, 80)

      assert [
               %ValidationError{
                 message: "hp must be less than or equal to 30",
                 path: "hp"
               }
             ] == validate_less_than_or_equal_to(@attrs, :hp, 30)

      assert [] == validate_less_than_or_equal_to(@attrs, :exp, 30)
    end
  end

  describe "validate_boolean_fields/2" do
    test "validates booleam fields" do
      assert [] == validate_boolean_fields(@attrs, ~w[is_mega]a)
      assert [] == validate_boolean_fields(%{@attrs | is_mega: false}, ~w[is_mega]a)
      assert [] == validate_boolean_fields(%{@attrs | is_mega: true}, ~w[is_mega]a)

      assert [] == validate_boolean_fields(%{}, ~w[is_mega]a)

      assert [
               %ValidationError{
                 message: "is_mega must be a boolean (value: yes)",
                 path: "is_mega"
               }
             ] ==
               validate_boolean_fields(%{@attrs | is_mega: "yes"}, ~w[is_mega]a)
    end
  end

  describe "validate_uuid/2" do
    test "validates uuid fields" do
      assert [] == validate_uuid_fields(@attrs, ~w[id]a)

      assert [] == validate_uuid_fields(%{}, ~w[id]a)

      assert [] ==
               validate_uuid_fields(%{@attrs | id: nil}, ~w[id]a)

      assert [
               %Valicon.ValidationError{
                 message: "id must be a UUID (value: 123)",
                 path: "id"
               }
             ] == validate_uuid_fields(%{@attrs | id: "123"}, ~w[id]a)

      assert [
               %Valicon.ValidationError{
                 message: "id must be a UUID (value: 12)",
                 path: "id"
               }
             ] ==
               validate_uuid_fields(%{@attrs | id: 12}, ~w[id]a)
    end
  end
end
