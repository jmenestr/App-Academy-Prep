require_relative "board"
require_relative "player"
require_relative "computer"
require "byebug"
class BattleshipGame

  attr_accessor :current_player, :other_player

  def initialize(player1,player2,setup = false,ships = 1)
    #byebug
    @current_player = player1
    @other_player = player2
    @current_player.board = Board.new(ships)
    @other_player.board = Board.new(ships)

    if setup
      setup_ships(ships)
    else
      @current_player.board.populate_grid
      @other_player.board.populate_grid
    end

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

  def setup_ships(ships)
    @current_player.place_ships(ships)
    @other_player.place_ships(ships)
  end

  private 
    def play_turn
      display(other_player.board)
      current_player.prompt
      begin 
        move = current_player.get_move(other_player.board)
        attack(other_player.board,move)
      rescue
        puts "Invalid move. Try again."
        play_turn
      end
      
    end

    def attack(board,pos)
      if board.has_ship?(pos)
        puts "You hit!"
        board[pos] = :x
      elsif board[pos].nil?
        puts "Miss"
        board[pos] = :o
      else
        puts "Move already played"
      end
    end

    def count_ships(board)
      board.count
    end

    def game_over?
      other_player.board.won?
    end

    def display(board)
      board.display
      puts "#{count_ships(board)} ships remain."
    end

    def switch_players
      @current_player, @other_player = @other_player, @current_player
    end

end

if __FILE__ == $PROGRAM_NAME
  BattleshipGame.new(HumanPlayer.new("Justin"),HumanPlayer.new("Kristen"),setup = true).play
end
