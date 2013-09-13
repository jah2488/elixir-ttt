Code.require_file "test_helper.exs", __DIR__

defmodule RulesTest do
  use ExUnit.Case
  import Rules

  test "split_duplicates" do
    assert choose_most_common([1,1,2]) == 1
    assert choose_most_common([7,7,7,1,1,1,7]) == 7
  end

  test "move: takes open move" do
    board = [:x, :blank, :x, :o, :x, :o, :o, :x, :o]
    assert move(board, :x) == 1
    assert move(board, :o) == 1
  end

  test "move: takes win over block for x" do
    board = [:x, :blank, :x, :o, :x, :o, :o, :blank, :o]
    assert move(board, :x) == 1
  end

  test "move: takes win over block for o" do
    board = [:x, :blank, :x, :o, :x, :o, :o, :blank, :o]
    assert move(board, :o) == 7
  end

  test "move: takes o" do
    assert move(Board.new_board, :x) == 0
    assert move(Board.new_board, :o) == 0
  end

  test "best_move: takes open moves" do
    board = [:x, :blank, :x, :o, :x, :o, :o, :x, :o]
    assert best_move(board, :x) == 1
    assert best_move(board, :o) == 1
  end

  test "best_move: takes win over a block" do
    board = [:x, :blank, :x, :o, :x, :o, :o, :blank, :o]
    assert best_move(board, :x) == 1
    assert best_move(board, :o) == 7
  end

  test "filter_moves: takes win over a block" do
    board = [:x, 1, :x, :o, :x, :o, :o, 7, :o]
    assert filter_available_moves(board, :x) == [1, 7]
    assert filter_available_moves(board, :o) == [7, 1]
  end

  test "stalemate: returns true if the board contains no blank markers" do
    board = [:x, :o, :x, :o, :x, :o, :o, :o, :o]
    assert stalemate(board) == true
  end

  test "available_moves: returns an empty list for an ended game" do
    board = [:x, :o, :x, :o, :x, :o, :o, :o, :o]
    assert available_moves(board) == []
  end

  test "player_wins?: Returns winning marker -> horizontal" do
    board = [:x, :x, :x, :blank, :blank, :blank, :blank, :blank, :blank]
    assert player_wins?(board, :x) == true
  end

  test "player_wins?: Returns winning marker -> vertical" do
    board = [:x, :blank, :blank, :x, :blank, :blank, :x, :blank, :blank]
    assert player_wins?(board, :x) == true
  end

  test "player_wins?: Returns winning marker -> diag" do
    board = [:o, :blank, :blank, :blank, :o, :blank, :blank, :blank, :o]
    assert player_wins?(board, :o) == true
  end

  test "choose_most_common: returns first elem if all the like." do
    assert choose_most_common([1,1,1]) == 1
  end

  test "choose_most_common: returns first most common elem odd." do
    assert choose_most_common([1,1,2]) == 1
  end

  test "choose_most_common: returns first most common elem even." do
    assert choose_most_common([1,1,2,3]) == 1
  end

  test "choose_most_common: returns first elem when even." do
    assert choose_most_common([1,1,2,2]) == 1
  end
end
