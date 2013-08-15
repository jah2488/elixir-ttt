defmodule TestIO do
  def puts(msg), do: msg
end

defmodule ConsoleDisplay do

  @board_labels 0..9
  @row_spacer  "\n---+---+---\n"
  @cell_spacer "|"

  def welcome,     do: "Elixir Tic Tac Toe"
  def puts(msg, out // TestIO), do: out.puts(msg)

  def print_board(board // Board.new_board) do
    board
      |> board_with_labels
      |> split_board
      |> Enum.map_join(@row_spacer, fn(row) -> print_row(List.flatten(row)) end)
  end

  def board_with_labels(board // Board.new_board) do
    Enum.zip(board, @board_labels)
  end

  def split_board( board // board_with_labels) do
    [board
        |> Enum.take(3),
      board
        |> Enum.drop(3)
        |> Enum.take(3),
      board
        |> Enum.drop(6)
        |> Enum.take(3)]
  end

  def print_row(row) do
    Enum.map_join(row, @cell_spacer, fn(cell) -> print_cell(cell) end)
  end

  def print_cell({ nil,  num }), do: " #{num} "
  def print_cell({ marker, _ }), do: " #{marker} "

end
