defmodule Negamax do

  def max, do:  100
  def tie, do:    0
  def min, do: -100

  def run(board, marker) do
    cond do
      Rules.player_wins?(board, marker)                 -> max
      Rules.player_wins?(board, Rules.opposite(marker)) -> min
      Rules.stalemate(board)                            -> tie
      true                                              -> check_spaces(board, marker)
    end
  end

  defp check_spaces(board, marker) do
    board
      |> Rules.available_moves
      |> Enum.map(fn move ->
              run(Board.place_move(board, move, Rules.opposite(marker)), Rules.opposite(marker))
         end)
  end

  def best_move(board, marker) do
    { cell, _ }  = board
      |> Rules.available_moves
      |> Enum.zip(run(board, marker))
      |> Enum.max_by(fn { _, score} -> score end)
    cell
  end
end
