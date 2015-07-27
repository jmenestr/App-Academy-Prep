# Syntactic Sugar for classes with a grid-like instance variable

**Note:** You can get by totally fine without understanding any of the
topics in this article. So if you find this information confusing, you
can pretty safely ignore it (for now, at least) and just do things in a
way that you do understand.

We'll be writing a number of board games over the next couple of weeks.
Many of these board games are played on a two-dimensional grid. In our
code, we represent these grids with 2D arrays.

For example, a tic tac toe game board/grid:

```
grid = [
  [:X, nil, :O],
  [:X, :O, nil],
  [nil, nil, nil]
]
```

## Basic 2D array access

We can easily get the value of the cell at the top-right corner of the
game board like so:

```
grid[0][2] # => :o
```

And we can change the value at a position like so:

```
grid[2][0] = :x
```

This works plenty fine. But by defining two special Ruby methods, `[]`
and `[]=`, we can do a little bit better.

## Special methods: `[]` and `[]=`

A `Board` class:

```
# board.rb
class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(3) { Array.new(3) }
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  ...
end
```

We can call these methods like so:

```
board = Board.new
board.[](2, 0) # returns the bottom-left square
board.[]=(0, 1, :x) # sets the top-middle square to :x
```

But that's uglier than the original way! However, Ruby gives us some
syntactic sugar that allows us to call the `[]` and `[]=` methods in a
convenient and non-standard way, a.k.a. "syntactic sugar."

## The Syntactic Sugar

These are all equivalent ways to get the bottom-left square:

```
board.grid[2][0]
board.[](2, 0)
board[2, 0] # syntactic sugar
```

The syntactic sugar allows us to call the `Board#[]` method with our
arguments inside of the square brackets themselves rather than in
parentheses following the square brackets.

Similarly, the following are equivalent ways to set the top-right
square:

```
board.grid[0][2] = :x
board.[]=(0, 2, :x)
board[0, 2] = :x  # syntactic sugar
```

Naturally, if we bother to set up the special `[]` and `[]=` methods,
we'll use the syntactic sugar way. :)

## A Good Time to Splat

We'll often have a variable called `pos` that is a pair of coordinates
in `[row, col]` format. For example, the bottom-middle tic tac toe
square corresponds to a `pos` of `[2, 1]`. Suppose we want to get the
value of that bottom-middle square. We could use our special getter
method as such:

```
row, col = pos # destructuring assignment
board[row, col] # => value of the square at the pos
```

Better yet, to save ourselves a line of code, we can use the splat
operator:

```
board[*pos] # => value of the square at the pos
```

To explain: if `pos` is `[2, 1]`, then we can't just say `board[pos]`,
because this would translate into `board[[2, 1]]`, which translates into
`board.[]([2, 1])`. But this doesn't work, because we defined our
`Board#[]` method to take *two* arguments (`row, col`), not a single
array argument.

The **splat operator** effectively takes an array argument and treats it
as if its elements were each an individual argument. So in our example,
`board[*[2, 1]]` effectively becomes `board[2, 1]`, which becomes
`board.[](2, 1)`, which contains two separate arguments, which is just
what the `Board#[]` method expects.

We can similarly set the value of the grid at a certain pos (for
example, `board[*pos] = :x`).
