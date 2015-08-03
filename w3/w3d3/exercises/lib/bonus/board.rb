require_relative "ship"
class Board

require 'byebug'
  def self.default_grid 
    Array.new(10) {Array.new(10,nil)}
  end


  attr_accessor :grid
  attr_reader :ship_number

  def initialize(grid = Board.default_grid)
    @grid = grid
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
    grid.flatten.count(Ship)
  end

  def empty?(pos = nil)
    if pos
    self[pos].nil?
    else
      return false if count > 0
      return true
    end
  end

  def set_ship(current_ship)
    #byebug
    positions = current_ship.positions
    raise "Ship placement is not valid" unless valid_position_array?(positions)
    positions.each do |p|
      self[p] = current_ship
    end

  end

  def has_ship?(pos)
    self[pos].is_a?(Ship)
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
    row >= 0 and column >= 0 and row < grid.length and column < grid.first.length
  end

  def display(setup = false)
      display_hash = {
        x:     "x",
        o:     "o",
        nil => " "
       }
      row_sep = "--+-" * grid.length + "\n"
      col_sep = " | " 
      display_grid = grid.map do |row| 
        row.map do |space| 
          
          if space.is_a?(Ship)
            if setup
              space.to_s
            else
              " "
            end
          else
            display_hash[space]
          end
        end
      end
      puts display_grid.map {  |row| "" +row.join(col_sep) + " |\n" }.join(row_sep)
  end

  def won?
    return false if grid.flatten.any? {|pos| pos.is_a?(Ship)}
    true
  end

  def full?
    grid.flatten.all? {|pos| !pos.nil?}
  end
end

