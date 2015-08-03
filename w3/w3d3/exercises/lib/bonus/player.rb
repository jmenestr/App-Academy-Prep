
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

  def handle_result(pos, hit)
  end

  def place_ships(ships)

    puts "Please select the spaces you'd like to put them in (ie 3 4)."
    
    ships.keys.each do |s|
      begin
        current_ship = ships[s].call #This will be an instance of the ship class
        board.display(setup = true)
        puts "Place your #{s} with length #{current_ship.length}"
        position = get_move  
        direction = promt_direction 
        current_ship.set_position(position,direction)
        board.set_ship(current_ship)
      rescue RuntimeError
        retry
      end
    end
  end


  def promt_direction
    puts "What direction do you want your ship to face (n s e w)"
    gets.chomp.downcase
  end



end
