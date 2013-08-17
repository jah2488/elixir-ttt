defmodule Board do

  def new_board do
    [nil, nil, nil,
     nil, nil, nil,
     nil, nil, nil]
  end

  def place_move(board, :x , _), do: board
  def place_move(board, :o , _), do: board
  def place_move(board // new_board, move, marker) do
      board
        |> list_to_tuple
        |> set_elem(move, marker)
        |> tuple_to_list
  end

  def move_available(board, move) do
    Enum.at(board, move) == nil
  end
end
