defmodule TicTacToe.Game do
  use GenServer

  # Client API

  def start_link(%Tabletop.Board{} = board) do
    GenServer.start_link(__MODULE__, board)
  end

  def take_turn(pid, piece, position) do
    GenServer.call(pid, {:take_turn, {piece, position}})
  end

  # Server API

  def init(%Tabletop.Board{} = board) do
    {:ok, board, 1000 * 60}
  end

  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  def handle_call({:take_turn, {piece, position}}, _from, board) do
    case TicTacToe.Turn.take_turn(board, piece, position) do
      %Tabletop.Board{} = updated_board ->
        {:reply, {:ok, updated_board}, updated_board}
      {:error, _reason} = response ->
        {:reply, response, board}
    end
  end

end
