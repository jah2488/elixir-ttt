defmodule Rules do

  def best_move(board, marker) do
    if (Enum.count(Enum.filter(board, fn cell -> cell == nil end)) == 1) do
      board
        |> available_moves
        |> Enum.filter(fn cell -> is_number(cell) end)
        |> Enum.first
    else
      board
        |> available_moves
        |> filter_moves(marker)
        |> Enum.filter(fn cell -> is_number(cell) end)
        |> Enum.first
    end
  end

  def filter_moves(board, marker) do
    lc cell inlist board do
      if cell in 0..9 do
        if player_wins?(Board.place_move(board, cell, marker), marker) do
          cell
        end
      else
        cell
      end
    end
  end

  def available_moves(board) do
    lc { cell, index } inlist Enum.zip(board, 0..9) do
      if cell == nil do
        index
      else
        cell
      end
    end
  end

  def player_wins?(board, marker) do
    Enum.any?(lc move_set inlist winning_moves do
      [lc move inlist move_set, do: Enum.at(board, move)]
        |> Enum.all?(fn n -> Enum.all?(n, fn x -> x == marker end) end)
    end)
  end

  def winning_moves do
    [[0,1,2],[3,4,5],[6,7,8],
     [0,4,8],[6,4,2],
     [0,3,6],[1,4,7],[2,5,8]]
  end
end
