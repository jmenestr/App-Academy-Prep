class Hangman
  attr_reader :guesser, :referee, :board
  MAX_GUESSES = 10

  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
    setup
  end

  def setup
    length = @referee.pick_secret_word
    @guesser.register_secret_length(length)
    @board = [nil] * length
  end

  def play
    guess = MAX_GUESSES
    while guess > 0
      take_turn
      if winner?
        puts "You won!"
        break
      end
    guess -= 1
    end
    puts "You lost!"
  end

  def take_turn
    puts display
    guess = @guesser.guess(@board)
    matches = @referee.check_guess(guess)
    update_board(guess,matches)
    @guesser.handle_response(guess,matches)
  end

  def winner?
    @board.all? {|char| !char.nil?}
  end


  def update_board(guess,matches)
    matches.each {|index| @board[index] = guess}
  end

  def display
    output = ""
    output << "Secret word: "   
    output << @board.map {|space| space.nil? ? "_" : space}.join("")
    output << "\n"
  end
end

class HumanPlayer

  def register_secret_length(length)
    puts "The length of the word is #{length}"
  end

  def pick_secret_word
    puts "What is the length of the secret word?"
    gets.chomp.to_i
  end

  def guess(board)
    puts "Please guess a letter"
    gets.chomp
  end

  def check_guess(letter)
    puts "Is '#{letter}'' in the word? (y/n)"
    answer = gets.chomp
    if answer == "y"
      puts "Where in word is '#{letter}' located? (ex. 3,4)"
      return phrase(gets.chomp)
    elsif answer == "n"
      return []
    end
  end

  def handle_response(guess,matches)
    if matches.empty?
      puts "'#{guess}' is not in the world"
    else
    puts "Your guess '#{guess}' was located at #{matches}"
   end
  end

  def phrase(input)
    input.split(",").map {|index| Integer(index)}
  end
end

class ComputerPlayer

  attr_reader :dictionary
  attr_accessor :secret_word, :candidate_words

  def self.dictionary_from_file(file)
    words = []
    File.open(file,"r").readlines.each do |line|
      words << line.chomp
    end
    words
  end

  def initialize(dictionary)
    @dictionary = dictionary
  end

  def pick_secret_word
    @secret_word = dictionary.sample.split("")
    secret_word.length
  end

  def check_guess(letter)
    secret_word.each_index.select {|index| secret_word[index] == letter}
  end

  def guess(board)
    past_guesses = board.compact.uniq
    most_common_letter = @candidate_words.join("").each_char.inject(Hash.new(0)) do |h,char|
      h[char] += 1
      h
    end
    most_common_letter.delete_if {|char,count| past_guesses.include?(char)}
    max = most_common_letter.values.max
    letters = most_common_letter.keys
    letters.select {|char| most_common_letter[char] == max}.first

  end

  def register_secret_length(length)
    @candidate_words = @dictionary.select {|word| word.length == length}
  end

  def handle_response(letter,matches)
    @candidate_words = @candidate_words.select do |word|
      letter_index(word,letter) == matches
    end
  end

  def letter_index(word,letter)
    (0...word.length).find_all {|index| word[index] == letter}
  end

end
computer = ComputerPlayer.new(ComputerPlayer.dictionary_from_file("dictionary.txt"))
human = HumanPlayer.new
Hangman.new(referee: computer, guesser: human).play

