require 'byebug'
class ComputerPlayer

  attr_reader :name, :board
  attr_accessor :mark

  LINES = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def initialize(name)
    @name = name
  end

  def display(board)
    @board = board
  end

  def get_move
    # Source: https://en.wikipedia.org/wiki/Tic-tac-toe
    # The following game implements the following AI strategy for a perfect game
    # The computer will choose the first case in which there is a valid move
    # 1. Win: If the player has two in a row, they can place a third to get three in a row.
    # 2. Block: If the opponent has two in a row, the player must play the third themselves to block the opponent.
    # 3. Fork: Create an opportunity where the player has two threats to win (two non-blocked lines of 2).
    # 4. Blocking an opponent's fork:
    #       Option 1: The player should create two in a row to force the opponent into defending, 
    #         as long as it doesn't result in them creating a fork. For example, if "X" has a corner, 
    #         "O" has the center, and "X" has the opposite corner as well, "O" must not play a corner 
    #         in order to win. (Playing a corner in this scenario creates a fork for "X" to win.)
    #       Option 2: If there is a configuration where the opponent can fork, the player should block that fork.
    # 5. Center: A player marks the center. (If it is the first move of the game, playing on a corner gives "O" 
    #    more opportunities to make a mistake and may therefore be the better choice; however, it makes no difference 
    #    between perfect players.)
    # 6. Opposite corner: If the opponent is in the corner, the player plays the opposite corner.
    # 7. Empty corner: The player plays in a corner square.
    # 8. Empty side: The player plays in a middle square on any of the 4 sides.
    
    return near_wins(mark) if near_wins(mark)
    return near_wins(other_mark) if near_wins(other_mark)
    return look_for_fork(other_mark) if look_for_fork(other_mark)
    return look_for_fork(mark) if look_for_fork(mark) 
    return center_move if center_move
    return opposite_corner if opposite_corner
    random_move
  end


  private
    # Method checks to see if there is a winning position held by the computer 
    # or if there's a winning position the computer has to block for the opponent
    def near_wins(marker)
      LINES.each do |winning_line|
        markers = group_positions_by_marker(winning_line)
        if markers[marker].length == 2 and markers.keys.include?(nil)      
            return move_map(markers[nil].first)
          end
      end
      false
    end
    #Looks for a move that would create two winning moves on the following turn
    # Returns that move is one exists
    def look_for_fork(marker)
      @board.free_positions.each do |position|
        #byebug
        flat_board = flatten_board
        flat_board[position] = marker
        return move_map(position) if possible_fork?(flat_board)
      end
      false
    end

      # Helper function to chec kif there is a possible fork for a given game state
    def possible_fork?(game_state)
      possible_wins = 0
      LINES.each do |line|
        markers = group_positions_by_marker(line,game_state)
        if markers[mark].length == 2 and markers.keys.include?(nil)
          possible_wins += 1 
        end
        return true if possible_wins == 2
      end
      nil
    end

    def center_move
      return [1,1] if board.empty?([1,1])
      false
    end

    def opposite_corner
      
      opposite_corner_map = {[0,0] => [2,2], [2,2] => [0,0], [0,2] => [2,0], [2,0] => [0,2]}
      opposite_corner_map.keys.each do |corner|
        op_cor = opposite_corner_map[corner]
        return opposite_corner_map[corner] if board[*corner] == other_mark && board.empty?(op_cor)
        end
        false
     end


    def random_move
      moves = []
      flatten_board.each_with_index{|space,i| moves << move_map(i) if space.nil?}
      #byebug
      moves.sample
    end

    def group_positions_by_marker(line, game_state = flatten_board)
      markers = line.group_by {|position| game_state[position]}
      markers.default = []
      markers
    end

    def move_map(flattened_position)
          move_map = {
        0 => [0,0],
        1 => [0,1],
        2 => [0,2],
        3 => [1,0],
        4 => [1,1],
        5 => [1,2],
        6 => [2,0],
        7 => [2,1],
        8 => [2,2]
      }
      move_map[flattened_position]
    end

    def other_mark
      return :X if mark == :O
      :O
    end

    #Refactor so the board has function flatten
    def flatten_board
      #byebug
      @board.flatten  
    end
end
