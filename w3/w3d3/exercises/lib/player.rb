class HumanPlayer
  def initialize(name)
    @name = name
  end

  def get_move
    gets.chomp.split(" ").map {|num| num.to_i}
  end

  def prompt
    print "Plese enter a move (such as 3 4): "
  end
end
