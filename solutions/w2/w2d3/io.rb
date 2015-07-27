def guessing_game
  secret = rand(1..10)

  guesses = 0
  while true
    puts "Guess a number!"
    guess = Integer(gets.chomp)
    guesses += 1

    case guess <=> secret
    when -1
      puts "#{guess} is too low!"
    when 0
      puts "You found the number #{guess}!"
      break
    when 1
      puts "#{guess} is too high!"
    end
  end

  puts "It took you #{guesses} guesses"
end

def shuffle_file(filename)
  base = File.basename(filename, ".*")
  extension = File.extname(filename)
  File.open("#{base}-shuffled#{extension}", "w") do |f|
    File.readlines(filename).shuffle.each do |line|
      f.puts line.chomp
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.length == 1
    shuffle_file(ARGV.shift)
  else
    puts "ENTER FILENAME TO SHUFFLE:"
    filename = gets.chomp
    shuffle_file(filename)
  end
end
