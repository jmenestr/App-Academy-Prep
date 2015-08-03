class ComputerPlayer

  attr_accessor :board 

  def initialize(name)
    @name = name
    @past_moves = []
  end

  def prompt
    puts "It's the computer's turn" 
    gets  
  end

  def get_move(board)
    #byebug
    move = board.all_positions.select do |position| 
      position if !@past_moves.include?(position)
    end.sample
    @past_moves << move
    move
  end


end