defmodule Aoc2023.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc_2023,
      version: "0.1.0",
      elixir: "~> 1.15",
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
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false},
      {:benchee, "~> 1.0", only: :dev},
      {:math, "~> 0.6.0"}
    ]
  end
end
