defmodule ExShopify.Mixfile do
  use Mix.Project

  def project do
    [app: :exshopify,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [mod: {ExShopify, []},
     applications: [:httpoison, :logger, :poison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:httpoison, "~> 0.10.0"},
     {:poison, "~> 3.0.0"},
     # dev
     {:ex_doc, ">= 0.0.0", only: :dev},
     #test
     {:bypass, "~> 0.5.1", git: "https://github.com/PSPDFKit-labs/bypass", only: :test}]
  end
end
