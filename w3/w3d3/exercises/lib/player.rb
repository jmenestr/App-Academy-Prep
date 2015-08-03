
require_relative "ship"
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
    ships = {
    "Battleship" => Ship.method(:battleship),
    "Aircraft Carrier" => Ship.method(:aircraft_carrier),
    "Submarine" => Ship.method(:submarine),
    "Destroyer" => Ship.method(:destroyer),
    "Patrol Boat" => Ship.method(:patrol_boat)
    }
    puts "Please select the spaces you'd like to put them in (ie 3 4)."
    ships.keys.each do |s|
      current_ship = ships[s] #This will be an instance of the ship class
      board.display(setup = true)
      print "Place your #{ship >> "}
      position = get_move
      print "What direction do you want your ship to face (n s e w)"
      direction = gets.chomp.downcase  
      board[position] = :s
    end
  end
end
