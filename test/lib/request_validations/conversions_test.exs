defmodule RequestValidations.ConversionsTest do
  use ExUnit.Case, async: true

  alias RequestValidations.ConversionError

  import RequestValidations.Conversions

  describe "cast/2" do
    test "casts the values of the given keys" do
      map = %{
        string: "42",
        integer: "42",
        float: "42.0",
        boolean: "true",
        false: "false",
        list: "a,b,c",
        other_list: ["a", "b", "c"],
        date: "2024-07-08"
      }

      assert {:ok,
              %{
                string: "42",
                integer: 42,
                float: 42.0,
                boolean: true,
                list: ["a", "b", "c"],
                date: ~D[2024-07-08],
                false: false,
                other_list: ["a", "b", "c"]
              }} ==
               cast(map,
                 string: :string,
                 integer: :integer,
                 float: :float,
                 boolean: :boolean,
                 false: :boolean,
                 list: :list,
                 other_list: :list,
                 date: :date
               )
    end

    test "cast gives back the original map when no keys are given" do
      map = %{
        string: "42",
        integer: "42",
        float: "42.0",
        boolean: "true",
        list: "a,b,c",
        date: "2024-07-08"
      }

      assert {:ok, map} == cast(map, foo: :string)
    end

    test "cast gives back the original map when non existing keys are given" do
      map = %{
        string: "42",
        integer: "42",
        float: "42.0",
        boolean: "true",
        list: "a,b,c",
        date: "2024-07-08"
      }

      assert {:ok, map} == cast(map, [])
    end

    test "cast returns the errors when the conversion fails" do
      map = %{
        string: 42,
        integer: "true",
        float: "true",
        boolean: "22",
        list: true,
        date: "true"
      }

      assert {:error,
              [
                %ConversionError{
                  message: "date must be a value of date type",
                  path: "date"
                },
                %ConversionError{
                  message: "list must be a value of list type",
                  path: "list"
                },
                %ConversionError{
                  message: "boolean must be a value of boolean type",
                  path: "boolean"
                },
                %ConversionError{
                  message: "float must be a value of float type",
                  path: "float"
                },
                %ConversionError{
                  message: "integer must be a value of integer type",
                  path: "integer"
                },
                %ConversionError{
                  message: "string must be a value of string type",
                  path: "string"
                }
              ]} ==
               cast(map,
                 string: :string,
                 integer: :integer,
                 float: :float,
                 boolean: :boolean,
                 list: :list,
                 date: :date
               )
    end
  end

  describe "atomize_keys/1" do
    test "atomizes only given keys" do
      map = %{"foo" => 1, "bar" => 2, "baz" => 3}
      assert %{foo: 1, bar: 2} == atomize_keys(map, ~w[foo bar]a)
    end

    test "ignores non exsting keys" do
      map = %{"foo" => 1, "bar" => 2, "baz" => 3}
      assert %{foo: 1, bar: 2, baz: 3} == atomize_keys(map, ~w[foo bar baz qux]a)
    end
  end

  describe "trim_whitespaces/1" do
    test "recursively removes all the trailing whitespaces of the map values" do
      map = %{
        first_level: "  The first level   ",
        non_string: 42,
        nested: %{
          nested: %{
            third_level: "    The third level      "
          }
        }
      }

      assert %{
               first_level: "The first level",
               non_string: 42,
               nested: %{
                 nested: %{
                   third_level: "The third level"
                 }
               }
             } == trim_whitespaces(map)
    end
  end
end
