defmodule Exshopify.MixProject do
  use Mix.Project

  def project do
    [
      app: :exshopify,
      version: "0.4.0",
      elixir: "~> 1.4",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:hackney, "~> 1.14", optional: true},
      {:dialyxir, "~> 1.0.0-rc", only: [:dev, :test], runtime: false}
    ]
  end
end
