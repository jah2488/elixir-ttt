defmodule Rules do

  def negawat(board, marker, 0) do
    moves = board |> available_moves
    Enum.map(moves, fn cell ->
      best_move( Board.place_move(board, cell, marker), marker )
    end)
  end

  def negawat(board, marker, depth // 2) do
    moves = board |> available_moves
    Enum.map(moves, fn cell ->
      move = best_move( Board.place_move(board, cell, marker), marker )
      new_board = Board.place_move(board, move, marker)
      negawat(new_board, opposite(marker), depth - 1)
    end)
  end


  def choose_most_common(list) do
    dup_list = Enum.map_reduce(list, [], fn (x, acc) ->
      { x , if(Enum.member?(acc,x), do: acc -- [x], else: acc ++ [x]) }
    end)
      |> tuple_to_list

    [ head | rest ] = dup_list
    Enum.first(head -- List.flatten(rest))
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

  def opposite(:x), do: :o
  def opposite(:o), do: :x

  defp map_board_to_win_sets(board) do
    lc move_set inlist winning_moves do
      lc move inlist move_set, do: Enum.at(board, move)
    end
  end

end
