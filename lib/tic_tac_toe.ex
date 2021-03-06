defmodule TicTacToe do

  def start do
    ConsoleDisplay.puts(ConsoleDisplay.welcome, IO)
    play_game(Board.new_board, :x)
  end

  def play_game(board, marker) do
    IO.puts System.cmd('clear')
    ConsoleDisplay.puts(ConsoleDisplay.print_board(board), IO)

    new_board = Board.place_move(board, player_move(board, marker), marker)

    unless Rules.game_over?(new_board), do: play_game(new_board, Rules.opposite(marker))
    start # Insert Game Over Logic Here
  end

  def player_move(board, :o), do: Negamax.best_move(board, :o)
  def player_move(board, :x) do
    move = case String.strip(IO.gets('-> ')) do
      ""   -> player_move(board, :x)
      move -> binary_to_integer(move)
    end

    unless(valid?(board, move), do: player_move(board, :x))
    move
  end


  def valid?(board, move) when  (move in 0..8), do: Board.move_available(board, move)
  def valid?(    _, move) when !(move in 0..8), do: false

end
