Code.require_file "test_helper.exs", __DIR__

defmodule BoardTest do
  use ExUnit.Case
  import Board

  test "New Board: Returns Empty Board" do
    assert new_board == [:blank, :blank, :blank, :blank, :blank, :blank, :blank, :blank, :blank]
  end

  test "Place Move: Returns Board with Move" do
    assert place_move(new_board, 1, :x) == [:blank, :x, :blank, :blank, :blank, :blank, :blank, :blank, :blank]
  end

  test "Place Move: Updates Current Board with Move" do
    board = [:blank, :x, :blank, :blank, :blank, :blank, :blank, :blank, :blank]
    assert place_move(board, 0, :o) == [:o, :x, :blank, :blank, :blank, :blank, :blank, :blank, :blank]
  end

  test "Move Available: Returns True for Empty Board." do
    assert move_available(new_board, 1) == true
  end

  test "Move Available: Returns True false for full board." do
    board = [:blank, :x, :blank, :blank, :blank, :blank, :blank, :blank, :blank]
    assert move_available(board, 1) == false
  end

end
