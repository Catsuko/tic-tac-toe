defmodule TicTacToe.Turn do

  def take_turn(board, piece, position) do
    cond do
      invalid_piece?(piece) ->
        {:error, :invalid_piece}
      !Tabletop.in_bounds?(board, position) ->
        {:error, :out_of_bounds}
      out_of_turn?(board, piece) ->
        {:error, :out_of_turn}
      Tabletop.occupied?(board, position) ->
        {:error, :position_taken}
      game_is_over?(board) ->
        {:error, :game_over}
      true ->
        add_to_history(board, position)
          |> Tabletop.take_turn(add: {piece, position})
    end
  end

  def piece_to_place(%Tabletop.Board{turn: turn}) do
    if Integer.mod(turn, 2) == 0, do: TicTacToe.cross(), else: TicTacToe.nought()
  end

  def last_move(board) do
    last_position = List.last(Tabletop.Board.get(board, :history))
    {Tabletop.get_piece(board, last_position), last_position}
  end

  defp out_of_turn?(board, piece) do
    !Tabletop.Piece.equal?(piece, piece_to_place(board))
  end

  defp invalid_piece?(%Tabletop.Piece{id: id}) do
    id != :O && id != :X
  end

  defp game_is_over?(board) do
    Tabletop.Board.get(board, :outcome) != :playing
  end

  defp add_to_history(board, position) do
    history = Tabletop.Board.get(board, :history)
    Tabletop.Board.assign(board, history: history ++ [position])
  end

end
