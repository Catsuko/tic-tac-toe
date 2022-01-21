defmodule TicTacToeConsole do

  def main do
    board = TicTacToe.fresh_board()
    {:ok, pid} = TicTacToe.Game.start_link(board)
    evaluate(board, pid)
  end

  def evaluate(board, pid) do
    board
      |> render_board()
      |> handle_outcome(pid)
  end

  def render_board(%Tabletop.Board{pieces: pieces} = board) do
    squares = Enum.map pieces, fn {_pos, piece} ->
      case piece do
        %Tabletop.Piece{id: id} ->
          Atom.to_string(id)
        _ ->
          "-"
      end
    end

    board_string = Enum.chunk_every(squares, 3)
      |> Enum.map(&Enum.join/1)
      |> List.flatten
      |> Enum.join("\n")

    IO.puts("\n" <> board_string <> "\n")
    board
  end

  def handle_outcome(board, pid) do
    case TicTacToe.Outcome.outcome(board) do
      :playing ->
        take_turn(board, pid)
      outcome ->
        render_outcome(outcome)
        ask_to_play_again()
    end
  end

  def take_turn(board, pid) do
    piece = TicTacToe.Turn.piece_to_place(board)
    pos = get_position(piece)

    try do
      take_turn(board, pid, piece, pos)
    catch
      :exit, _ ->
        IO.puts("Sorry, your game timed out")
        ask_to_play_again()
    end
  end

  def take_turn(board, pid, piece, pos) do
    case TicTacToe.Game.take_turn(pid, piece, pos) do
      {:ok, updated_board} ->
        evaluate(updated_board, pid)
      {:error, reason} ->
        IO.puts(reason)
        take_turn(board, pid)
    end
  end

  def render_outcome(outcome) do
    case outcome do
      {:winner, %Tabletop.Piece{id: id}} ->
        Atom.to_string(id) <> " wins!!!"
      :draw ->
        "draw!!!"
    end
      |> IO.puts
  end

  def ask_to_play_again do
    cond do
      String.match?(IO.gets("Do you want to play again?\n"), ~r/y.*/i) ->
        IO.puts("\n")
        main()
    end
  end

  defp get_position(%Tabletop.Piece{id: id} = piece) do
    IO.puts(Atom.to_string(id) <> " to move")
    case IO.gets("\n") do
      <<"go ", x::binary-size(1), ",", y::binary-size(1), _rest>> ->
        {String.to_integer(y), String.to_integer(x)}
      _ ->
        IO.puts("invalid input, use: 'go x,y'")
        get_position(piece)
    end
  end

end
