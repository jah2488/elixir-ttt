Code.require_file "test_helper.exs", __DIR__

defmodule BoardTest do
  use ExUnit.Case
  import Board

  test "New Board: Returns Empty Board" do
    assert new_board == [nil, nil, nil, nil, nil, nil, nil, nil, nil]
  end

  test "Place Move: Returns Board with Move" do
    assert place_move(new_board, 1, :x) == [nil, :x, nil, nil, nil, nil, nil, nil, nil]
  end

  test "Place Move: Updates Current Board with Move" do
    board = [nil, :x, nil, nil, nil, nil, nil, nil, nil]
    assert place_move(board, 0, :o) == [:o, :x, nil, nil, nil, nil, nil, nil, nil]
  end

  test "Move Available: Returns True for Empty Board." do
    assert move_available(new_board, 1) == true
  end

  test "Move Available: Returns True false for full board." do
    board = [nil, :x, nil, nil, nil, nil, nil, nil, nil]
    assert move_available(board, 1) == false
  end

end
