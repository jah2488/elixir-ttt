Code.require_file "test_helper.exs", __DIR__

defmodule RulesTest do
  use ExUnit.Case
  import Rules

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

  test "stalemate: returns true if the board contains no blank markers" do
    board = [:x, :o, :x, :o, :x, :o, :o, :o, :o]
    assert stalemate(board) == true
  end

end
