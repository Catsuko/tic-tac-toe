# TicTacToe

Implemented using the [tabletop](https://github.com/Catsuko/tabletop) library.

## Playing a Game

Use the `TicTacToeConsole` to play a game in your elixir console:

```elixir
iex> TicTacToeConsole.main()

---
---
---

O to move

```

Input a move with `go x,y` where `0,0` is the top left and `2,2` is the bottom right. First player to get 3 of their pieces in a line wins!
