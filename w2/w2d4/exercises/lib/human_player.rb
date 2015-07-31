class HumanPlayer

  def initialize(name)
    @name = name
  end

  attr_reader :name

  def get_move
    puts "Where would you like to move: "
    pos = gets.chomp.split(",").map {|pos| pos.to_i}
  end

  def display(board)
    board.print_board
  end

end
