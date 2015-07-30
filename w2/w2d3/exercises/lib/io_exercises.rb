# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
  num_guesses = 0
  random = Random.new.rand(1..100)
  loop do
    print "Please guess a number (1-100): "
    guess = gets.chomp.to_i
    num_guesses += 1
    if guess == random
      puts "You guessed the correct number #{guess} in #{num_guesses} tries."
      break
    elsif guess > random
      puts "Your guess #{guess} is too high. Please try again"
    elsif guess < random
      puts "Your guess #{guess} is too low. Please try again"
    end

  end
end

def shuffled_file(file)
  extension = File.extname(file)
  base = File.basename(file, extension)
  File.open("#{base}-shuffled#{extension}", "w+") do |f|
    File.open(file,"r").readlines.shuffle.each do |line|
      f.puts line
    end
  end 
end

def promt_user_for_file

  puts "Enter a file to shuffle"
  file = gets.chomp
  return shuffled_file(file) if File.exist?(file)
end

promt_user_for_file