defmodule Rules do

  def available_moves(board) do
    if game_over?(board) do
      []
    else
      Enum.with_index(board)
        |> Enum.map(available_cell(&1))
        |> Enum.filter(is_number(&1))
    end
  end

  def available_cell({ :blank, i }), do: i
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

  def opposite(:x), do: :o
  def opposite(:o), do: :x

  def stalemate(board) do
    !(Enum.any?(board, fn cell -> cell == :blank end))
  end

  def game_over?(board) do
    Enum.any? [stalemate(board), player_wins?(board, :o), player_wins?(board, :x)]
  end

  defp map_board_to_win_sets(board) do
    lc move_set inlist winning_moves do
      lc move inlist move_set, do: Enum.at(board, move)
    end
  end

end
