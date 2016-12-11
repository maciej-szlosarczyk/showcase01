defmodule Domain.Mixfile do
  use Mix.Project

  def project do
    [app: :domain,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :postgrex, :ecto],
     mod: {Domain, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:myapp, in_umbrella: true}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    # Databases
    [{:ecto, "~> 2.0"},
     {:postgrex, "~> 0.12.0"},
     {:ex_machina, "~> 1.0", only: :test},

     # authentication and authorization
     {:comeonin, "~> 2.5"}, # Password hashing

     # Other libraries
     {:timex, "~> 3.1"}] # Time and date made easy
  end
end
