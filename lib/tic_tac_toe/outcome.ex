defmodule TicTacToe.Outcome do

  def decide_outcome(%Tabletop.Board{turn: turn} = board) do
    cond do
      line_exists?(board) ->
        Tabletop.Board.assign(board, outcome: :winner)
      turn == 9 ->
        Tabletop.Board.assign(board, outcome: :draw)
      true ->
        board
    end
  end

  def outcome(%Tabletop.Board{attributes: attributes} = board) do
    case Map.fetch!(attributes, :outcome) do
      :winner = outcome ->
        {piece, _position} = TicTacToe.Turn.last_move(board)
        {outcome, piece}
      outcome ->
        outcome
    end
  end

  defp line_exists?(%Tabletop.Board{turn: turn} = board) do
    cond do
      turn < 5 ->
        false
      true ->
        line_exists_from?(board, TicTacToe.Turn.last_move(board))
    end
  end

  defp line_exists_from?(board, {piece, position}) do
    horizontal_exists?(board, position, piece) or
      vertical_exists?(board, position, piece) or
      diagonal_left_exists?(board, piece) or
      diagonal_right_exists?(board, piece)
  end

  defp horizontal_exists?(board, position, piece) do
    Tabletop.travel(board, position, fn {x, y} -> {Integer.mod(x + 1, 3), y} end)
      |> all_match?(piece)
  end

  defp vertical_exists?(board, position, piece) do
    Tabletop.travel(board, position, fn {x, y} -> {x, Integer.mod(y + 1, 3)} end)
      |> all_match?(piece)
  end

  defp diagonal_left_exists?(board, piece) do
    Tabletop.travel(board, {0, 0}, fn {x, y} -> {x + 1, y + 1} end)
      |> all_match?(piece)
  end

  defp diagonal_right_exists?(board, piece) do
    Tabletop.travel(board, {0, 2}, fn {x, y} -> {x + 1, y - 1} end)
      |> all_match?(piece)
  end

  defp all_match?(path, target_piece) do
    matching = path
      |> Stream.take(3)
      |> Enum.count(fn {_pos, piece} -> piece != nil and Tabletop.Piece.equal?(target_piece, piece) end)
    matching == 3
  end

end
