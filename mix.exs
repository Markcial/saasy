defmodule Saasy.MixProject do
  use Mix.Project

  def project do
    [
      app: :saasy,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Task aliases
      aliases: aliases(),

      # escript configuration
      escript: [main_module: Saasy.Cli],

      # Docs
      name: "Saasy",
      source_url: "https://github.com/markcial/saasy",
      homepage_url: "http://github.com/markcial/saasy",
      # The main page in the docs
      docs: [main: "Saasy", extras: ["README.md"]]
    ]
  end

  defp aliases do
    [
      saasy: &saasy_cli_main/1,
      docker: &docker/1
    ]
  end

  defp saasy_cli_main(args) do
    Mix.Task.run("compile")
    Application.ensure_all_started(:yamerl)
    Saasy.Cli.main(args)
  end

  defp docker(_) do
    Mix.Shell.IO.error("Pending implementation")
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :yamerl, :bunt]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:yamerl, "~> 0.4.0"},
      {:jason, "~> 1.0"},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:credo, "~> 0.9.0-rc1", only: [:dev, :test], runtime: false}
    ]
  end
end
