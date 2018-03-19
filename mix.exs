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

      # Coverage
      test_coverage: [
        tool: Coverex.Task
      ],

      # Docs
      name: "Saasy",
      source_url: "https://github.com/markcial/saasy",
      homepage_url: "http://github.com/markcial/saasy",
      # The main page in the docs
      docs: [main: "Saasy", extras: ["README.md"]],

      # Task environments
      preferred_cli_env: [
        cover: :test,
        rtfm: :dev
      ]
    ]
  end

  defp aliases do
    [
      saasy: &saasy_cli_main/1,
      docker: &docker/1,
      cover: &coverage/1,
      rtfm: &rtfm/1
    ]
  end

  defp saasy_cli_main(args) do
    Mix.Task.run("compile")
    Application.ensure_all_started(:yamerl)
    Saasy.Cli.main(args)
  end

  defp docker(_) do
    Mix.Shell.cmd(
      "docker build -t saasy .",
      &IO.write/1
    )
    Mix.Shell.IO.info(~S"""
    Docker image build successfully
    ==============================
    Execute it with the documents on the data volume.
    Exple.: docker run --rm \
        -v $(pwd)/input:/application/input \
        saasy --provider capterra
    """)
  end

  defp coverage(_) do
    Mix.Task.run("test", ["--cover"])
    System.cmd("open", ["cover/modules.html"])
  end

  defp rtfm(_) do
    Mix.Task.run("compile")
    Mix.Task.run("docs")
    System.cmd("open", ["doc/index.html"])
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
      {:coverex, "~> 1.4.10", only: [:dev,:test], runtime: false},
      {:ex_doc, "~> 0.16", only: [:dev,:test], runtime: false},
      {:credo, "~> 0.9.0-rc1", only: [:dev, :test], runtime: false}
    ]
  end
end
