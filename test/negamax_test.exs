Code.require_file "test_helper.exs", __DIR__

defmodule NegamaxTest do
  use ExUnit.Case
  import Negamax

  test "run: max for winning piece" do
    board = [:x,     :x,     :x,
             :blank, :blank, :blank,
             :blank, :blank, :blank]
    assert run(board, :x) == max
  end

  test "run: min for losing piece" do
    board = [:x,     :x,     :x,
             :blank, :blank, :blank,
             :blank, :blank, :blank]
    assert run(board, :o) == min
  end

  test "run: 0 for stalemate" do
    board = [:x, :o, :x,
             :o, :x, :o,
             :o, :x, :o]
    assert run(board, :x) == tie
    assert run(board, :o) == tie
  end

  test "move: takes open move" do
    board = [:x, :blank, :x, :o, :x, :o, :o, :x, :o]
    assert best_move(board, :x) == 1
    assert best_move(board, :o) == 1
  end

  test "move: takes win over block for x" do
     board = [:x, :blank, :x, :o, :x, :o, :o, :blank, :o]
     assert best_move(board, :x) == 1
  end

  test "move: takes win over block for o" do
    board = [:x, :blank, :x, :o, :x, :o, :o, :blank, :o]
    assert best_move(board, :o) == 7
  end

  test "move: makes move after player" do
    board = [:x,     :blank, :blank,
             :blank, :blank, :blank,
             :blank, :blank, :blank]
    assert best_move(board, :o) == 5
    assert best_move(board, :x) == 2
  end

  test "move: takes o" do
    #assert best_move(Board.new_board, :x) in [0,2,6,8]
    #assert best_move(Board.new_board, :o) in [0,2,6,8]
  end

end
