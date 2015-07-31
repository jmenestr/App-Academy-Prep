class Board

  def self.empty_board
    Array.new(3) {Array.new(3,nil)}
  end

  def initialize(grid = Board.empty_board)
    @grid = grid
    @marks = [:X, :O]
  end

  attr_accessor :grid, :marks

  def [](row,col)
    @grid[row][col]
  end

  def []=(row,col,mark)
    @grid[row][col] = mark
  end

  def empty?(pos)
    self[*pos].nil?
  end

  def place_mark(pos,mark)
    #raise "Position is not empty" if !empty?(pos)
    self[*pos] = mark
  end

  def draw?
    @grid.flatten.all? {|space| !space.nil?}
  end

  def winner
    (rows + columns + diagonals).each do |line|
      return :X if line == [:X, :X, :X]
      return :O if line == [:O, :O, :O]
    end
    nil
  end

  def over?
    return true if winner or draw?
    false
  end

  def flatten
    @grid.flatten
  end

  def free_positions
    positions = []
    flatten.each_with_index {|space,i| positions << i if space.nil?}
    positions
  end

    def print_board
      display_hash = {nil => " ", X: "X", O: "O"}
      row_sep = "--+---+--\n"
      col_sep = " | "
      display_grid = grid.map {|row| row.map {|space| display_hash[space]}}
      puts display_grid.map {  |row| row.join(col_sep) + "\n" }.join(row_sep)
    end

    def rows
      @grid
    end

    def columns
      columns = [[],[],[]]
      @grid.each do |row|
        row.each_with_index do |marker,index|
          columns[index].push(marker)
        end
      end
      columns
    end

    def diagonals
    [
      [self[0,0],self[1,1],self[2,2]],
      [self[0,2],self[1,1],self[2,0]]
    ]
    end

end

Board.new.print_board
