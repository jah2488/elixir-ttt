Code.require_file "test_helper.exs", __DIR__

defmodule DisplayTest do
  use ExUnit.Case
  import ConsoleDisplay

  test "Welcome: Greets Player" do
    assert welcome == "Elixir Tic Tac Toe"
  end

  test "Split Rows: Splits board into rows" do
    assert split_board == [[{nil,0}, {nil,1}, {nil,2}],
                           [{nil,3}, {nil,4}, {nil,5}],
                           [{nil,6}, {nil,7}, {nil,8}]]
  end

  test "Print Row: Prints row with numbers" do
    assert print_row([{nil,0}, {nil,1}, {nil,2}]) == " 0 | 1 | 2 "
  end

  test "Print Row: Prints row with markers" do
    assert print_row([{nil,0}, {'x',1}, {'o',2}]) == " 0 | x | o "
  end

  test "Print Cell: Prints Marker Cell" do
    assert print_cell({'x', 0}) == " x "
  end

  test "Print Cell: Prints Blank Cell" do
    assert print_cell({nil, 0}) == " 0 "
  end

  test "Print Board: Displays The Board" do
    assert print_board == " 0 | 1 | 2 \n---+---+---\n 3 | 4 | 5 \n---+---+---\n 6 | 7 | 8 "
  end
end
