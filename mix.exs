defmodule Shopify.MixProject do
  use Mix.Project

  def project do
    [
      app: :exshopify,
      version: "0.11.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [plt_add_apps: [:gen_stage, :hackney]],
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test,
        "coveralls.post": :test,
        "coveralls.travis": :test
      ],
      test_coverage: [
        tool: ExCoveralls
      ],
      xref: [
        exclude: [
          Shopify.Client.Hackney,
          Shopify.RateLimiter.Partition,
          Shopify.RateLimiter.Producer
        ]
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
      {:gen_stage, ">= 0.14.0 and < 2.0.0", optional: true},
      {:hackney, "~> 1.14", optional: true},
      {:jason, "~> 1.1", optional: true},
      # dev
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      # test
      {:excoveralls, "~> 0.10", only: :test, runtime: false},
      # dev/test
      {:dialyxir, "~> 1.0.0-rc", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      description: "Elixir client for the Shopify REST API",
      maintainers: ["Anthony Smith"],
      licenses: ["MIT"],
      links: %{
        GitHub: "https://github.com/sticksnleaves/exshopify"
      }
    ]
  end
end
