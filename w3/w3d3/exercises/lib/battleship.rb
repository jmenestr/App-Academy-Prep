require_relative "board"
require_relative "player"
class BattleshipGame
  attr_reader :board, :player

  def initialize(player,board)
    @player = player
    @board = board
  end

  def attack(pos)
    if board.has_ship?(pos)
      puts "You hit!"
      board[pos] = :x
    else
      puts "Miss"
      board[pos] = :o
    end

  end

  def count
    board.count
  end

  def game_over?
    board.won?
  end

  def display
    board.display
  end

  def play_turn

    display

    player.prompt
    begin
      move = player.get_move
      attack(move)
    rescue
      puts "Invalid move. Try again."
    end
    
  end

  def play
    until count == 0
      play_turn
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  BattleshipGame.new(HumanPlayer.new("Justin"),Board.new).play
end
