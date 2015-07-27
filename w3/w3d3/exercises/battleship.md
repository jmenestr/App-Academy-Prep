# Battleship

Let's write a basic implementation of the classic game
[Battleship][wiki-battleship]!

[wiki-battleship]: http://en.wikipedia.org/wiki/Battleship_%28game%29

## Guidelines

You should start with a very basic implementation. Write Battleship as a
single-player game; it's you against the game. There is only one board;
the computer will fill it with ships at random, and it will be your job
to find and destroy these ships by guessing their coordinates.

As in previous projects, you should organize your program using multiple
classes; each class should have clear responsibilities and encapsulate a
distinct part of the overall game "story". I split my program into the
following classes:

- A `Board` class with an underlying `grid` (a two-dimensional Array),
  where each element in a row represents a ship, open water, or a space
  that has already been attacked. I used the symbol `:s` to represent an
  undamaged ship (or ship segment), `nil` for empty space, and `:x` to
  represent a destroyed space. Useful Board methods:
  - `Board#display`: prints the board, with marks on any spaces that
    have been fired upon.
  - `Board#count`: returns the number of valid targets (ships) remaining
  - `Board#populate_grid` to randomly distribute ships across the board
  - `Board#in_range?(pos)`
- A `HumanPlayer` class, responsible for translating user input into
  positions of the form `[x, y]`
- A `BattleshipGame` class to enforce rules and run the game. The game
  should keep a reference to the Player, as well as the Board. Some
  (possibly) useful methods:
  - `BattleshipGame#play`: runs the game by calling `play_turn` until
    the game is over.
  - `BattleshipGame#play_turn`: gets a guess from the player and makes
    an attack.
  - `BattleshipGame#attack(pos)`: Marks the board at `pos`, destroying
    or replacing any ship that might be there.
  - `BattleshipGame#display_status`: Prints information on the current
    state of the game, including board state and the number of ships
    remaining.

**Note**: You probably won't need a Ship class (at least, not at first).
As noted above, a simple Symbol is sufficient for the basic
implementation. For the bonus phase, however, you probably will want to
write this class.

## Bonus

- Add a ComputerPlayer class that will fire at random positions on the
  board. Make it as smart as you can; ensure that it doesn't fire at the
  same position twice. You should not need to modify any logic internal
  to your Game class in order to support computer players.
- Refactor your game so that there are two players, each with his or her
  own board. Players should take turns firing at each other's fleet.
- Introduce a "setup" phase, where each player can place ships on their
  board.
- Update your game to use different types of ships, each of a different
  size. Here are the canonical ship sizes (though of course you could
  choose your own):

| Ship type | Dimensions |
| ----------|----------- |
| Aircraft carrier | 5x1 |
| Battleship | 4x1 |
| Submarine | 3x1 |
| Destroyer (or Cruiser) | 3x1 |
| Patrol boat (or destroyer) | 2x1 |
