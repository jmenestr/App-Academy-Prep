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

  def populate_grid
    #byebug
    ship_number.times do
      place_random_ship
    end
  end

  def place_ship(pos)
    self[pos] = :s
  end

  def display(ships = false)
      display_hash = {
        nil => " ",
        s: ships ? "s" : " ",
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
    place_ship(empty_positions.sample)
  end


  def full?
    grid.flatten.all? {|pos| !pos.nil?}
  end
end

