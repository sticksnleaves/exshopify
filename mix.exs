defmodule ExShopify.Mixfile do
  use Mix.Project

  def project do
    [app: :exshopify,
     name: "ExShopify",
     description: "Elixir client for the Shopify API",
     version: "0.2.0",
     package: package,
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     preferred_cli_env: ["coveralls": :test, "coveralls.details": :test,
                         "coveralls.html": :test, "coveralls.post": :test,
                         "coveralls.travis": :test],
     test_coverage: [tool: ExCoveralls]]
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
     {:poison, ">= 2.2.0 or < 3.1.0"},
     # dev
     {:ex_doc, ">= 0.0.0", only: :dev},
     #test
     {:bypass, "~> 0.5.1", git: "https://github.com/PSPDFKit-labs/bypass", only: :test},
     {:excoveralls, "~> 0.5.7", only: :test}]
  end

  defp package do
    [maintainers: ["Anthony Smith"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/sticksnleaves/exshopify"}]
  end
end
