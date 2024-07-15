defmodule Valicon.MixProject do
  use Mix.Project

  @name "Valicon"
  @version "1.0.0"
  @repo_url "https://github.com/starfish-codes/valicon"

  def project do
    [
      app: :valicon,
      version: @version,
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      description:
        "A comprehensive set of data structure validation and related helper functions, designed to work without external dependencies.",
      package: package(),
      deps: deps(),
      docs: docs(),
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

  defp package do
    [
      links: %{"GitHub" => @repo_url},
      licenses: ["MIT"]
    ]
  end

  defp docs do
    [
      source_ref: "v#{@version}",
      source_url: @repo_url,
      main: @name
    ]
  end
end
