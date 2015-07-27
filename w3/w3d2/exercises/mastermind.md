# Mastermind

In this project, you'll implement the game
[Mastermind][wiki-mastermind].

* There are six different peg colors:
    * Red
    * Green
    * Blue
    * Yellow
    * Orange
    * Purple
* The computer will select a random code of four pegs. (Duplicate colors
  are allowed.)
* The user gets ten turns to guess the code.
    * You decide how the user inputs his guess (maybe like so: "RGBY"
      for red-green-blue-yellow)
* The computer should tell the player how many exact matches (right
  color in right spot) and near matches (right color, wrong spot) he
  or she has.
* The game ends when the user guesses the code, or is out of turns.

## Suggestions

I wrote a `Code` and a `Game` class. My `Code` class represented a
sequence of four pegs. The `Game` kept track of how many turns has
passed, the correct `Code`, prompt the user for input.

I wrote a `Code::random` class method which builds a `Code` instance
with random peg colors. I also wrote a `Code::parse(input)` method
that took a user input string like `"RGBY"` and built a `Code`
object. I made code objects for both (1) the secret code and (2) the
user's guess of the code. I wrote methods like
`Code#exact_matches(other_code)` and `Code#near_matches(other_code)` to
handle comparisons.

[wiki-mastermind]: http://en.wikipedia.org/wiki/Mastermind_(game)
