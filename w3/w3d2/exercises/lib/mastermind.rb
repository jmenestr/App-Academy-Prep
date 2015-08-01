class Code
  attr_reader :pegs
  PEGS = {r: :red, g: :green, b: :blue, y: :yellow, o: :orange, p: :purple}

  def initialize(pegs)
  @pegs = pegs 
  end

  def self.random
    colors = PEGS.keys.map {|value| value.to_s}
    pegs = []
    4.times { pegs << colors.sample}
    Code.new(pegs)
  end

  def self.parse(string)
    pegs = string.split("").map {|char| char.downcase }
    pegs.each {|peg| raise "Invalid colors" if !PEGS.has_key?(peg.to_sym)}
    Code.new(pegs)
  end

  def exact_matches(other_code)
    matches = 0
    (0..3).each {|index| matches += 1 if pegs[index] == other_code[index] }
    matches
    #pegs.zip(other_code.pegs).select {|colors| colors.first == colors.last}.size
  end

  def near_matches(other_code)
    other_code.pegs.select {|peg| pegs.include?(peg)}.uniq.size - exact_matches(other_code)
  end

  def [](index)
    pegs[index]
  end

  def ==(other_code)
    return false if !other_code.is_a?(Code)
    other_code.pegs == self.pegs
  end

end

class Game
  attr_reader :secret_code
  MAX_GUESS = 10
  def initialize(code = Code.random)
    @secret_code = code 
  end

  def play
    guess_count = 0
    MAX_GUESS.times do
      puts "Guess the secret code"
      guess = get_guess
      guess_count += 1
      if @secret_code == guess
        "You won in #{guess_count}"
        break
      end
      display_matches(guess)
    end 
  end

  def get_guess
    
    begin
      Code.parse(gets.chomp)
      rescue
        puts "Invalid guess"
      retry
    end

    
  end

  def display_matches(code)
    exact = secret_code.exact_matches(code)
    near = secret_code.near_matches(code)

    puts "Your guess has #{exact} exact matches."
    puts "Your guess has #{near} near matches."
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end