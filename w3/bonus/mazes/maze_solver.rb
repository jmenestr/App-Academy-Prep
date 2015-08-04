require 'byebug'
class MazeSolver
  attr_accessor :grid, :cells, :open_cells, :closed_cells, :path
  attr_reader :height, :width, :start, :finish

  def initialize(maze)
    @grid = [] 
    File.open(maze,"r").readlines.each do |line|
      line.chomp
      @grid << line.chomp.split("")
    end
    @width = grid.first.length
    @height = grid.length
    @cells = []
    setup
    @start = find_start
    @finish = find_end   
    @open_cells = [@start]
    @closed_cells = []
    @path = []
  end

  def solve
    while open_cells.length > 0
      #print open_cells
      #byebug
      open_cells.sort_by! {|cell| cell.f}
      cell = open_cells.shift
      closed_cells << cell
      if cell == finish
        return get_parents
        break
        #display maze
      end
      get_adjacent_cells(cell).each do |adj_cell|
        
        if adj_cell.reachable and !closed_cells.include?(adj_cell)

          #If adjacent cell in open list, check to see if path is shortest
          if open_cells.include?(adj_cell)
            if adj_cell.g > (cell.g + 10)
              update_cell(cell,adj_cell)
            end
          else
            update_cell(cell,adj_cell)
            open_cells << adj_cell
          end
        end
      end
    end
  end

  def [](pos)
    row,col = *pos
    grid[row][col]
  end

  def []=(pos,marker)
    row,col = *pos
    grid[row][col] = marker
  end

  def to_s
    display = grid.map {|row| row.join("")}
    display.join("\n")
  end

  def get_cell(row,col)
    @cells.find {|cell| cell.row == row and cell.column == col}
  end

  def get_hueristic(cell)
    10 * ((finish.row - cell.row).abs + (finish.column - cell.column).abs)
  end

  def get_adjacent_cells(cell)
    cells = []
    #up
    up = [cell.row-1,cell.column]
    cells << get_cell(*up) if inside_maze?(up)
    #down
    down = [cell.row+1,cell.column]
    cells << get_cell(*down) if inside_maze?(down)
    #right
    right = [cell.row,cell.column+1]
    cells << get_cell(*right) if inside_maze?(right)
    #left
    left = [cell.row, cell.column - 1]
    cells << get_cell(*left) if inside_maze?(left)
    cells
  end

  def get_parents
    cell = finish
    while cell.parent != start
      cell = cell.parent
      self[[cell.row, cell.column]] = "X"  
    end   
  end

  def inside_maze?(pos)
    row,col = *pos
    return false unless (0...height).include? row
    return false unless (0...width).include? col
    true
  end

  def update_cell(current_cell,adjacent_cell)
    adjacent_cell.g = current_cell.g + 10
    adjacent_cell.h = get_hueristic(adjacent_cell)
    adjacent_cell.calculate_f
    adjacent_cell.parent = current_cell
  end

  def find_start
    
    grid.each_with_index do |row,i|
      row.each_with_index do |space,j|
         return get_cell(i,j) if grid[i][j] == "S"
      end
    end
  end

  def find_end
    grid.each_with_index do |row,i|
      row.each_with_index do |space,j|
        return get_cell(i,j) if grid[i][j] == "E"
      end
    end
  end

  def setup

    grid.each_with_index do |row,i|
      row.each_with_index do |space,j|
        @cells << Cell.new(i,j,reachable?([i,j]))
      end
    end
    
  end

  def reachable?(pos)
    if self[pos] == "+" or self[pos] == "-" or self[pos] == "|"
      return false
    end
    true
  end

end

class Cell
  attr_reader :row,:column,:reachable, :f
  attr_accessor :g, :h, :parent
  def initialize(row,column,reachable)
    @row = row
    @column = column
    @parent = nil
    @g = 0
    @h = 0
    @f = 0
    @reachable = reachable
  end

  def calculate_f
    @f = @g + @h
  end
end



x = MazeSolver.new("maze1.txt")
x.solve
puts x.to_s
