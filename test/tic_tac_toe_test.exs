Code.require_file "test_helper.exs", __DIR__

defmodule TicTacToeTest do
  use ExUnit.Case
  import TicTacToe
  import Board

  test "Testing works" do
    assert 1=1
  end

  test "game_over?" do
    assert game_over?(new_board) == false
  end

  test "game_over?: true for a board with a winning move set" do
    board = new_board
              |> place_move(0, :x)
              |> place_move(1, :x)
              |> place_move(2, :x)
    assert game_over?(board) == true
  end

  test "valid? in range and valid" do
    assert valid?(Board.new_board, 1)  == true
  end

  test "valid? in range and invalid" do
    assert valid?([:x, nil, nil], 0) == false
  end

  test "valid? out of range" do
    assert valid?(Board.new_board, 10) == false
  end
end
