defmodule Rules do

  def best_move(board, marker) do
    board
      |> available_moves
      |> filter_available_moves(marker)
      |> take_first_move
  end

  def take_first_move(board) do
    Enum.filter(board, fn cell -> is_number(cell) end)
      |> Enum.first
  end

  def filter_available_moves(board, marker) do
    Enum.uniq(
      Enum.filter(board, fn cell ->
          player_wins?(Board.place_move(board, cell, marker), marker)
      end) ++ Enum.filter(board, fn cell -> is_number(cell) end)
    )
  end

  def available_moves(board) do
    Enum.with_index(board)
      |> Enum.map(available_cell(&1))
  end

  def available_cell({ nil,    i }), do: i
  def available_cell({ marker, _ }), do: marker

  def player_wins?(board, marker) do
    map_board_to_win_sets(board)
      |> Enum.any?(fn set -> Enum.all?(set, fn x -> x == marker end) end)
  end

  def winning_moves do
    [[0,1,2],[3,4,5],[6,7,8],
     [0,4,8],[6,4,2],
     [0,3,6],[1,4,7],[2,5,8]]
  end

  defp map_board_to_win_sets(board) do
    lc move_set inlist winning_moves do
      lc move inlist move_set, do: Enum.at(board, move)
    end
  end

end
