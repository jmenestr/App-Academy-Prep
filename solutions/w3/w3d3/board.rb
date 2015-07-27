class Board
  DISPLAY_HASH = {
    nil => " ",
    :s => " ",
    :x => "x"
  }

  def self.default_grid
    Array.new(10) { Array.new(10) }
  end

  def self.random
    self.new(self.default_grid, true)
  end

  attr_reader :grid

  def initialize(grid = self.class.default_grid, random = false)
    @grid = grid
    randomize if random
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    grid[x][y] = val
  end

  def count
    grid.flatten.select { |el| el == :s }.length
  end

  def display
    header = (0..9).to_a.join("  ")
    p "  #{header}"
    grid.each_with_index { |row, i| display_row(row, i) }
  end

  def display_row(row, i)
    chars = row.map { |el| DISPLAY_HASH[el] }.join("  ")
    p "#{i} #{chars}"
  end

  def empty?(pos = nil)
    if pos
      self[pos].nil?
    else
      count == 0
    end
  end

  def full?
    grid.flatten.none?(&:nil?)
  end

  def in_range?(pos)
    pos.all? { |x| x.between?(0, grid.length) }
  end

  def place_random_ship
    raise "hell" if full?
    pos = random_pos

    until empty?(pos)
      pos = random_pos
    end

    self[pos] = :s
  end

  def randomize(count = 10)
    count.times { place_random_ship }
  end

  def random_pos
    [rand(size), rand(size)]
  end

  def size
    grid.length
  end

  def won?
    grid.flatten.none? { |el| el == :s }
  end
end
