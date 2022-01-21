defmodule TicTacToe.OutcomeTest do
  use ExUnit.Case
  doctest TicTacToe.Outcome

  describe "outcome" do
    test "winner when 3 of the same in a row" do
      result = TicTacToe.fresh_board()
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 0})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {0, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {1, 0})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {1, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {2, 0})
        |> TicTacToe.Outcome.outcome()
      assert {:winner, %Tabletop.Piece{id: :O}} = result
    end

    test "no outcome when only 2 in a row" do
      result = TicTacToe.fresh_board()
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 0})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {0, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {1, 0})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {1, 1})
        |> TicTacToe.Outcome.outcome()
      assert :playing = result
    end

    test "winner when 3 of the same column" do
      result = TicTacToe.fresh_board()
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 0})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {2, 0})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {2, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 2})
        |> TicTacToe.Outcome.outcome()
      assert {:winner, %Tabletop.Piece{id: :O}} = result
    end

    test "no outcome when only 2 in a column" do
      result = TicTacToe.fresh_board()
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 0})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {2, 0})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {2, 1})
        |> TicTacToe.Outcome.outcome()
      assert :playing = result
    end

    test "draw when all positions are full and no lines exist" do
      result = TicTacToe.fresh_board()
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 0})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {1, 0})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {2, 0})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {0, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {2, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {1, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 2})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {2, 2})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {1, 2})
        |> TicTacToe.Outcome.outcome()
      assert :draw = result
    end

    test "winner when diagonal from bottom left" do
      result = TicTacToe.fresh_board()
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 2})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {0, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {1, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {2, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {2, 0})
        |> TicTacToe.Outcome.outcome()
      assert {:winner, %Tabletop.Piece{id: :O}} = result
    end

    test "winner when diagonal from bottom right" do
      result = TicTacToe.fresh_board()
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {2, 2})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {0, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {1, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {2, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 0})
        |> TicTacToe.Outcome.outcome()
      assert {:winner, %Tabletop.Piece{id: :O}} = result
    end

    test "no outcome when diagonal is missing the middle piece" do
      result = TicTacToe.fresh_board()
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {2, 2})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {1, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.cross(), {2, 1})
        |> TicTacToe.Turn.take_turn(TicTacToe.nought(), {0, 0})
        |> TicTacToe.Outcome.outcome()
      assert :playing = result
    end
  end
end
