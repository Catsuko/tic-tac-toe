defmodule TicTacToe.Outcome do

  def decide_outcome(%Tabletop.Board{turn: turn} = board) do
    cond do
      line_exists?(board) ->
        Tabletop.Board.assign(board, %{outcome: :winner})
      turn == 9 ->
        Tabletop.Board.assign(board, %{outcome: :draw})
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

  defp line_exists_from?(board, last_move) do
    horizontal_exists?(board, last_move) or
      vertical_exists?(board, last_move) or
      diagonal_exists?(board, last_move)
  end

  defp horizontal_exists?(board, {piece, {_x, y}}) do
    Enum.all? 0..2, fn x -> matching_piece?(board, piece, {x, y}) end
  end

  defp vertical_exists?(board, {piece, {x, _y}}) do
    Enum.all? 0..2, fn y -> matching_piece?(board, piece, {x, y}) end
  end

  defp diagonal_exists?(board, {piece, {_x, _y}}) do
    (Enum.all? -1..1, fn offset -> matching_piece?(board, piece, {1 + offset, 1 - offset}) end)
      or (Enum.all? 0..2, fn offset -> matching_piece?(board, piece, {offset, offset}) end)
  end

  defp matching_piece?(board, %Tabletop.Piece{id: id}, position) do
    Tabletop.occupied?(board, position) and Tabletop.get_piece(board, position).id == id
  end

end
