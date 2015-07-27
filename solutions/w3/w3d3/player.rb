class HumanPlayer
  def initialize(name)
    @name = name
  end

  def get_play
    gets.chomp.split(",").map { |el| Integer(el) }
  end

  def prompt
    puts "Please enter a target square (i.e., '3,4')"
    print "> "
  end
end
