Code.require_file "test_helper.exs", __DIR__

defmodule DisplayTest do
  use ExUnit.Case
  import ConsoleDisplay

  test "Welcome: Greets Player" do
    assert welcome == "Elixir Tic Tac Toe"
  end

  test "Split Rows: Splits board into rows" do
    assert split_board == [[{:blank,0}, {:blank,1}, {:blank,2}],
                           [{:blank,3}, {:blank,4}, {:blank,5}],
                           [{:blank,6}, {:blank,7}, {:blank,8}]]
  end

  test "Print Row: Prints row with numbers" do
    assert print_row([{:blank,0}, {:blank,1}, {:blank,2}]) == " 0 | 1 | 2 "
  end

  test "Print Row: Prints row with markers" do
    assert print_row([{:blank,0}, {:x,1}, {:o,2}]) == " 0 |\e[32m x \e[m|\e[31m o \e[m"
  end

  test "Print Cell: Prints Blank Cell" do
    assert print_cell({:blank, 0}) == " 0 "
  end

  test "Print Board: Displays The Board" do
    assert print_board == " 0 | 1 | 2 \n---+---+---\n 3 | 4 | 5 \n---+---+---\n 6 | 7 | 8 "
  end
end
