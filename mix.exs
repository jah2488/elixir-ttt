defmodule TicTacToe.Mixfile do
  use Mix.Project

  def project do
    [ app: :tic_tac_toe,
      version: "0.0.2",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    []
  end
end
