defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  describe "nought" do
    test "creates a O Piece" do
      assert %Tabletop.Piece{id: :O} = TicTacToe.nought()
    end
  end

  describe "cross" do
    test "creates a X Piece" do
      assert %Tabletop.Piece{id: :X} = TicTacToe.cross()
    end
  end

end
