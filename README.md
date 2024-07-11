# Request validations
A collection of ectoless validation and helper functions for validation
of the pure data structures that came from the HTTP API.

## Usage

- Add request_validations to your list of dependencies in mix.exs:

```elixir
defp deps do
  [
    {:request_validations, "~> 0.1.0"}
  ]
end
```

- Use the functions in your code:

```elixir
defmodule MaApp.CustomerRequest do 
    use RequestValidations
 
    def new(attrs) do 
        attrs 
        |> atomize_keys(@allowed_keys)
        |> trim_whitespaces()
        |> validate([
             &validate_required(&1, ~w[:role]a),
             &validate_enum(&1, :role, ~w[user admin])
            ])

    end

end 

- Then in your controller you can use it like this:

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
