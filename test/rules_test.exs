Code.require_file "test_helper.exs", __DIR__

defmodule RulesTest do
  use ExUnit.Case
  import Rules

  test "best_move: takes open moves" do
    board = [:x, nil, :x, :o, :x, :o, :o, :x, :o]
    assert best_move(board, :x) == 1
    assert best_move(board, :o) == 1
  end

  test "best_move: takes win over a block" do
    board = [:x, nil, :x, :o, :x, :o, :o, nil, :o]
    assert best_move(board, :x) == 1
    assert best_move(board, :o) == 7
  end

  test "filter_moves: takes win over a block" do
    board = [:x, 1, :x, :o, :x, :o, :o, 7, :o]
    assert filter_available_moves(board, :x) == [1, 7]
    assert filter_available_moves(board, :o) == [7, 1]
  end

  test "player_wins?: Returns winning marker -> horizontal" do
    board = [:x, :x, :x, nil, nil, nil, nil, nil, nil]
    assert player_wins?(board, :x) == true
  end

  test "player_wins?: Returns winning marker -> vertical" do
    board = [:x, nil, nil, :x, nil, nil, :x, nil, nil]
    assert player_wins?(board, :x) == true
  end

  test "player_wins?: Returns winning marker -> diag" do
    board = [:o, nil, nil, nil, :o, nil, nil, nil, :o]
    assert player_wins?(board, :o) == true
  end
end
