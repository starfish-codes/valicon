# Validations and Conversions
A collection of ectoless validation and helper functions for validation
of pure data structures.

## Usage

- Add request_validations to your list of dependencies in mix.exs:

```elixir
defp deps do
  [
    {:valicon, "~> 1.0.2"}
  ]
end
```

## Example
For example you can use this validation on the pure HTTP data that comes in the controller. Before this data continues to the business logic.

First we need a module that will handle the validation of the data. This module will use the RequestValidations module. This will atomoize the allowed keys you provide and trim the whitespaces of the values. Then you can use the validate function to validate the data. If you want to add more validations you can add them to the list.

```elixir
defmodule MaApp.CustomerRequest do 
    use RequestValidations
 
    def new(attrs) do 
        attrs 
        |> atomize_keys(~w[role name id]a)
        |> trim_whitespaces()
        |> validate([
             &validate_required(&1, ~w[:role]a),
             &validate_enum(&1, :role, ~w[user admin])
            ])

    end

end 
```
Then in your controller you can use it like this:

```elixir
defmodule CustomerController do 
    ... 
     def create(conn, params) do
    with {:ok, data} <- CustomerRequest.new_customer(params),
         {:ok, customer} <- Customers.create(data) do
       render(conn,"customer.json", customer: customer)
    end
  end

end
```
