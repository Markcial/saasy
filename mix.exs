defmodule Saasy.MixProject do
  use Mix.Project

  def project do
    [
      app: :saasy,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "Saasy",
      source_url: "https://github.com/markcial/saasy",
      homepage_url: "http://github.com/markcial/saasy",
      docs: [main: "Saasy", # The main page in the docs
          extras: ["README.md"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :yamerl]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:yamerl, "~> 0.4.0"},
      {:jason, "~> 1.0"},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end
end
