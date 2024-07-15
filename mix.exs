defmodule Valicon.MixProject do
  use Mix.Project

  def project do
    [
      app: :valicon,
      version: "1.0.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      # For testing
      {:excoveralls, "~> 0.10", only: :test},
      {:faker, "~> 0.17", only: [:test]}
    ]
  end
end
