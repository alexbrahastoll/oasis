defmodule Oasis.MixProject do
  use Mix.Project

  def project do
    [
      app: :oasis,
      version: "0.1.0",
      elixir: "~> 1.9",
      escript: [main_module: Oasis.CLI, path: "./escript/oasis"],
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:yaml_elixir, "~> 2.4"}
    ]
  end
end
