class TowersOfHanoi
  attr_reader :towers

  def initialize
    @towers = [[3, 2, 1], [], []]
  end

  def play
    display

    until won?
      puts 'What tower do you want to move from?'
      from_tower = gets.to_i

      puts 'What tower do you want to move to?'
      to_tower = gets.to_i

      if valid_move?(from_tower, to_tower)
        move(from_tower, to_tower)
        display
      else
        display
        puts "Invalid move. Try again."
      end
    end

    puts 'You win!'
  end

  def won?
    @towers[0].empty? && @towers[1..2].any?(&:empty?)
  end

  def valid_move?(from_tower, to_tower)
    return false unless [from_tower, to_tower].all? { |i| i.between?(0, 2) }

    !@towers[from_tower].empty? && (
      @towers[to_tower].empty? ||
      @towers[to_tower].last > @towers[from_tower].last
    )
  end

  def move(from_tower, to_tower)
    @towers[to_tower] << @towers[from_tower].pop
  end

  def render
    'Tower 0:  ' + @towers[0].join('  ') + "\n" +
    'Tower 1:  ' + @towers[1].join('  ') + "\n" +
    'Tower 2:  ' + @towers[2].join('  ') + "\n"
  end

  def display
    # this moves everything up in the console so that whatever we print
    # afterwards appears at the top
    system('clear')
    puts render
  end
end

if $PROGRAM_NAME == __FILE__
  TowersOfHanoi.new().play
end
