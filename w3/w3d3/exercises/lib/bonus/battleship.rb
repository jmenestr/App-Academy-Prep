require_relative "board"
require_relative "player"
require_relative "computer"
require_relative "ship"

require "byebug"
class BattleshipGame

  attr_accessor :current_player, :other_player
  SHIPS = {
    "Battleship" => Ship.method(:battleship),
    "Aircraft Carrier" => Ship.method(:aircraft_carrier),
    "Submarine" => Ship.method(:submarine),
    "Destroyer" => Ship.method(:destroyer),
    "Patrol Boat" => Ship.method(:patrol_boat)
    }

  def initialize(player1,player2)
    #byebug
    @current_player = player1
    @other_player = player2
    @current_player.board = Board.new
    @other_player.board = Board.new

    setup_ships    
  end

  def play
    while true
      play_turn
      
      break if game_over?
      switch_players
    end
    display(other_player.board)
    puts "#{current_player.name} won! You hit all the ships"

  end

  def setup_ships
    @current_player.place_ships(SHIPS)
    @other_player.place_ships(SHIPS)
  end

  private 
    def play_turn

      begin 
        
        puts "Your oppoenets board"
        display(other_player.board)
        puts "Your board"
        display(current_player.board,ships = true)
        current_player.prompt
        
        move = current_player.get_move(other_player.board)
        hit = attack(other_player.board,move)
        @current_player.handle_result(hit,move)
      rescue
        puts "Invalid move. Try again."
        retry
      end
      
    end

    def attack(board,pos)
      puts "The move #{pos} was played."
      if board.has_ship?(pos)
        puts "You hit!"
        board[pos] = :x
        return true
      elsif board[pos].nil?
        puts "Miss"
        board[pos] = :o
      else
        
        puts "Move already played"
      end
      false
    end



    def game_over?
      other_player.board.won?
    end

    def display(board, ships = false)
      board.display(setup = ships)
    end

    def switch_players
      @current_player, @other_player = @other_player, @current_player
    end

end

if __FILE__ == $PROGRAM_NAME
  BattleshipGame.new(HumanPlayer.new("Justin"),ComputerPlayer.new("Kristen")).play
end
