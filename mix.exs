defmodule Valicon.MixProject do
  use Mix.Project

  @name "Valicon"
  @version "1.7.0"
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
        "coveralls.html": :test,
        "coveralls.json": :test
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
      {:faker, "~> 0.17", only: [:test]},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:mix_audit, "~> 2.1", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.34", only: [:dev], runtime: false}
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
