require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'
require 'byebug'

class Game
  def initialize(player1,player2)
    @player1 = player2
    @player2 = player1
    player1.mark = :X
    player2.mark = :O
    @current_player = @player1
    @other_player = @player2
    @board = Board.new
  end

  attr_reader :board, :current_player, :player1, :player2

  def play
    until board.over?
      #byebug
      play_turn
    end

    if game_winner
      puts "#{game_winner.name} won!"
    else
      puts "Game was a draw!"
      current_player.display(board)
    end

  end

  def play_turn
    current_player.display(board)

    move = current_player.get_move

    board.place_mark(move,current_player.mark)
    switch_players!
    

  end

  def game_winner
    return player1 if board.winner == :X
    return player2 if board.winner == :O
    nil
  end


  def switch_players!
    @current_player, @other_player = @other_player, @current_player
  end
end



if __FILE__ == $PROGRAM_NAME
  player1 = ComputerPlayer.new("Watson")
  player2 = HumanPlayer.new("Justin")

  Game.new(player1,player2).play
end