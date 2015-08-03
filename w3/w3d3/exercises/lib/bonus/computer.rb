class ComputerPlayer

  attr_accessor :board, :next_moves, :past_moves
  attr_reader :name

  def initialize(name)
    @name = name
    @past_moves = []
    @next_moves = [] 
  end

  def prompt
    puts "It's  #{name}'s turn" 
    gets  
  end

  def get_move(board)
    #byebug
    print next_moves
    print "\n"
    print past_moves
    print "\n"
    if @next_moves.empty?
      move = random_move(board)     
    else
      move = next_moves.shuffle.pop
    end
    @past_moves << move
    move
  end

  def handle_result(hit,pos)
    if hit    
      if @next_moves.empty?
        get_next_moves(pos)
      else
        @next_moves = []
        get_next_moves(pos)
      end
    end 
   @next_moves.delete_if {|move| !board.inside_grid?(move) or past_moves.include?(move)}
  end

  def random_move(board)
   board.all_positions.select do |position| 
      position if !past_moves.include?(position)
    end.sample
  end


  def get_next_moves(pos)
    #If computer hits successfully, will make a list of next moves to try
    #look north
    
    @next_moves << [pos[0]-1,pos[1]]
    #look south
    @next_moves << [pos[0]+1,pos[1]]
    #look east
    @next_moves << [pos[0],pos[1]+1]
    #look west
    @next_moves << [pos[0],pos[1]-1]   
    
    
  end

  def place_ships(ships)   
    ships.keys.each do |s|
      begin
        current_ship = ships[s].call #This will be an instance of the ship class
        position = board.all_positions.sample
        direction = %w[n s e w].sample 
        current_ship.set_position(position,direction)
        board.valid_position_array?(current_ship.positions)
        board.set_ship(current_ship)
      rescue RuntimeError
        retry
      end
    end
    #board.display(setup = true)
  end


end