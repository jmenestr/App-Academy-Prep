
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
    
    ships.times do
      puts "Please select the spaces you'd like to place a ship (ie 3 4)."
      board.display(setup = true)
      position = get_move
      board.place_ship(position)
    end
  end

end
