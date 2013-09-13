defmodule Rules do

  def move(board, marker) do
    negawat(board, marker)
      |> choose_most_common
  end

  def negawat(board, marker, depth // 4) when depth > 0 do

    moves = available_moves(board)

    move_tree = Enum.map(moves, fn cell ->
      move = best_move( Board.place_move(board, cell, marker), marker )
      new_board = Board.place_move(board, move, marker)
      negawat(new_board, opposite(marker), depth - 1)
    end)

    move_tree
      |> remove_empty
      |> choose_most_common
      |> List.flatten
  end

  def remove_empty(list) do
    Enum.filter(list, fn x -> !Enum.empty?(x) end)
  end

  def negawat(board, marker, 0) do
    board
      |> available_moves
      |> Enum.map(fn cell ->
          best_move( Board.place_move(board, cell, marker), marker )
         end)
  end

  def choose_most_common([]), do: []
  def choose_most_common(list) when is_list(list) do
     [ head | tail ] = Enum.map_reduce(list, [], fn (x, acc) ->
        { x , if(Enum.member?(acc,x), do: acc -- [x], else: acc ++ [x]) }
      end) |> tuple_to_list

      Enum.first(head -- List.flatten(tail))
  end

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
    if game_over?(board) do
      []
    else
      Enum.with_index(board)
        |> Enum.map(available_cell(&1))
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
