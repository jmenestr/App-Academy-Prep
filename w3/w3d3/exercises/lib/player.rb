class HumanPlayer

  attr_accessor :board
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_move(board = nil)
    gets.chomp.split(" ").map {|num| num.to_i}
  end

  def prompt
    print "It's #{name}'s turn. Plese enter a move (such as 3 4): "
  end

  def place_ships(ships)
    puts "#{name}, you have #{ships} you can place."
    puts "Please select the spaces you'd like to put them in (ie 3 4)."
    ships.times do
      board.display(setup = true)
      print "Place your ship >> "
      position = get_move
      board[position] = :s
    end
  end
end
