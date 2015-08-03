class Board

require 'byebug'
  def self.default_grid 
    Array.new(10) {Array.new(10)}
  end


  attr_accessor :grid
  attr_reader :ship_number

  def initialize(grid = Board.default_grid, ships)
    @grid = grid
    @ship_number = ships
  end

  def [](pos)
    row,col = *pos
    grid[row][col]
  end

  def []=(pos,marker)
    row,col = *pos
    grid[row][col] = marker
  end

  def count
    grid.flatten.count(:s)
  end

  def empty?(pos = nil)
    if pos
    self[pos].nil?
    else
      return false if count > 0
      true
    end
  end

  def has_ship?(pos)
    self[pos] == :s
  end

  def empty_positions
    positions = []
    grid.each_with_index do |row,i|
      row.each_with_index do |column, j|
        positions << [i,j] if empty?([i,j])
      end
    end
    positions
  end

  def all_positions
    all_positions = []
    grid.each_with_index do |row,i|
      row.each_with_index do |column, j|
        all_positions << [i,j] 
      end
    end
    all_positions
  end

  def valid_position_array?(pos_ary)
    #takes in array of pos arrays and checks to see if it's valid
    pos_ary.all? {|pos| inside_grid?(pos) and self[pos].nil?} 
  end

  def inside_grid?(pos)
    row = pos[0]
    column = pos[1]
    row >= 0 and column >= 0 and row < grid.length and column < gird.first.length
  end

  def populate_grid
    #byebug
    ship_number.times do
      place_random_ship
    end
  end

  def display(setup = false)
      display_hash = {
        nil => " ",
        s: setup ? "s" : " ",
        x: "x",
        o: "o"
       }
      row_sep = "--+-" * grid.length + "\n"
      col_sep = " | "
      display_grid = grid.map {|row| row.map {|space| display_hash[space]}}
      puts display_grid.map {  |row| row.join(col_sep) + " |\n" }.join(row_sep)
  end

  def won?
    return false if grid.flatten.any? {|pos| pos == :s}
    true
  end

  def place_random_ship
    raise "Board is full" if full?
    #byebug
    self[empty_positions.sample] = :s
  end

  def full?
    grid.flatten.all? {|pos| !pos.nil?}
  end
end

