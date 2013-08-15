defmodule TicTacToe do

  def start do
    ConsoleDisplay.puts(ConsoleDisplay.welcome, IO)
    play_game(Board.new_board, :x)
  end

  def play_game(board, marker) do
    ConsoleDisplay.puts(ConsoleDisplay.print_board(board), IO)

    new_board = Board.place_move(board, player_move(board), marker)

    if(game_over?(new_board)) do
      start
    else
      play_game(new_board, opposite(marker))
    end
  end

  def game_over?(board) do
    Enum.any? lc marker inlist [:x, :o], do: Rules.player_wins?(board, marker)
  end

  def player_move(board) do
    move = case String.strip(IO.gets('-> ')) do
      ""   -> player_move(board)
      move -> binary_to_integer(move)
    end

    if(valid?(board, move)) do
      move
    else
      player_move(board)
    end
  end


  def valid?(board, move) when  (move in 0..8), do: Board.move_available(board, move)
  def valid?(    _, move) when !(move in 0..8), do: false

  def opposite(:x), do: :o
  def opposite(:o), do: :x

end
