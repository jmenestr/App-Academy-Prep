class Hangman
  MAX_GUESSES = 8

  attr_reader :guesser, :referee, :board

  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
    @num_remaining_guesses = MAX_GUESSES
  end

  def play
    setup

    while @num_remaining_guesses > 0
      p @board
      take_turn

      if won?
        p @board
        puts "Guesser wins!"
        return
      end
    end

    puts "Word was: #{@referee.require_secret}"
    puts "Guesser loses!"

    nil
  end

  def setup
    secret_length = @referee.pick_secret_word
    @guesser.register_secret_length(secret_length)
    @board = [nil] * secret_length
  end

  def take_turn
    guess = @guesser.guess(@board)
    indices = @referee.check_guess(guess)
    update_board(guess, indices)
    @num_remaining_guesses -= 1 if indices.empty?

    @guesser.handle_response(guess, indices)
  end

  def update_board(guess, indices)
    indices.each { |index| @board[index] = guess }
  end

  def won?
    @board.all?
  end
end

class HumanPlayer
  def register_secret_length(length)
    puts "Secret is #{length} letters long"
  end

  def guess(board)
    p board
    puts "Input guess:"
    gets.chomp
  end

  def handle_response(guess, response)
    puts "Found #{guess} at positions #{response}"
  end

  def pick_secret_word
    puts "Think of a secret word; how long is it?"

    begin
      Integer(gets.chomp)
    rescue ArgumentError
      puts "Enter a valid length!"
      retry
    end
  end

  def check_guess(guess)
    puts "Player guessed #{guess}"
    puts "What positions does that occur at?"

    # didn't check for bogus input here; got lazy :-)
    gets.chomp.split(",").map { |i_str| Integer(i_str) }
  end

  def require_secret
    puts "What word were you thinking of?"
    gets.chomp
  end
end

class ComputerPlayer
  def self.player_with_dict_file(dict_file_name)
    ComputerPlayer.new(File.readlines(dict_file_name).map(&:chomp))
  end

  attr_reader :candidate_words

  def initialize(dictionary)
    @dictionary = dictionary
  end

  def pick_secret_word
    @secret_word = @dictionary.sample

    @secret_word.length
  end

  def check_guess(guess)
    response = []

    @secret_word.split("").each_with_index do |letter, index|
      response << index if letter == guess
    end

    response
  end

  def register_secret_length(length)
    # begining to play again; reset candidate_words
    @candidate_words = @dictionary.select { |word| word.length == length }
  end

  def guess(board)
    # I left this here so you can see it narrow things down.
    # p @candidate_words

    freq_table = freq_table(board)

    most_frequent_letters = freq_table.sort_by { |letter, count| count }
    letter, _ = most_frequent_letters.last

    # we'll never repeat a guess because we only look at unfilled
    # positions to calculate frequency, and we remove a word from the
    # candidates if it has a guessed letter in an unfilled position on
    # the board.
    letter
  end

  def handle_response(guess, response_indices)
    @candidate_words.reject! do |word|
      should_delete = false

      word.split("").each_with_index do |letter, index|
        if (letter == guess) && (!response_indices.include?(index))
          should_delete = true
          break
        elsif (letter != guess) && (response_indices.include?(index))
          should_delete = true
          break
        end
      end

      should_delete
    end
  end

  def require_secret
    @secret_word
  end

  private
  def freq_table(board)
    # this makes 0 the default value; see the RubyDoc.
    freq_table = Hash.new(0)
    @candidate_words.each do |word|
      board.each_with_index do |letter, index|
        # only count letters at missing positions
        freq_table[word[index]] += 1 if letter.nil?
      end
    end

    freq_table
  end
end

if __FILE__ == $PROGRAM_NAME
  # use print so that user input happens on the same line
  print "Guesser: Computer (yes/no)? "
  if gets.chomp == "yes"
    guesser = ComputerPlayer.player_with_dict_file("dictionary.txt")
  else
    guesser = HumanPlayer.new
  end

  print "Referee: Computer (yes/no)? "
  if gets.chomp == "yes"
    referee = ComputerPlayer.player_with_dict_file("dictionary.txt")
  else
    referee = HumanPlayer.new
  end

  Hangman.new(guesser, referee).play
end
