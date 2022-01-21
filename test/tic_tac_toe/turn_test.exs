defmodule TicTacToe.TurnTest do
  use ExUnit.Case
  doctest TicTacToe.Turn

  describe "take turn" do
    test "error using wierd piece" do
      result = TicTacToe.fresh_board()
        |> TicTacToe.Turn.take_turn(%Tabletop.Piece{id: :JUNK}, {0,0})
      assert {:error, :invalid_piece} = result
    end

    test "error when draw" do
      result = TicTacToe.fresh_board()
        |> Tabletop.Board.assign(%{outcome: :draw})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 0})
      assert {:error, :game_over} = result
    end

    test "error winner is declared" do
      result = TicTacToe.fresh_board()
        |> Tabletop.Board.assign(%{outcome: :winner})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 0})
      assert {:error, :game_over} = result
    end

    test "error playing X on first turn" do
      result = TicTacToe.fresh_board()
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {0, 0})
      assert {:error, :out_of_turn} = result
    end

    test "error playing O on second turn" do
      result = TicTacToe.fresh_board()
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 0})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 1})
      assert {:error, :out_of_turn} = result
    end
  end
end
