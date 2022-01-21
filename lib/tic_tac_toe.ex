defmodule TicTacToe do

  def nought do
    %Tabletop.Piece{id: :O}
  end

  @spec cross :: %Tabletop.Piece{attributes: %{}, id: :X}
  def cross do
    %Tabletop.Piece{id: :X}
  end

  def fresh_board do
    Tabletop.Board.square(3)
      |> Tabletop.Board.add_effects(&TicTacToe.Outcome.decide_outcome/1)
      |> Tabletop.Board.assign(history: [], outcome: :playing)
  end

end
