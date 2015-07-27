#!/usr/bin/env ruby

# The top line tells the shell that this should be runnable as a Ruby
# script. So I should be able to run `./rpn.rb` (after setting the
# file to "executable" by `chmod +x rpn.rb`).

require_relative "../w2d1/12_rpn_calculator"

# extend the RPNCalculator class from our previous solution
class RPNCalculator
  def self.evaluate_file(file)
    file.each do |line|
      line = line.chomp
      calc = RPNCalculator.new
      puts calc.evaluate(line)
    end
  end

  def self.prompt
    puts "Enter a number or operator (ENTER to quit)"
    print "> "
  end

  def self.run_ui
    calc = RPNCalculator.new
    string = ""

    loop do
      prompt
      input = gets.chomp
      break if input.empty? # Stop asking for input if the user hits ENTER
      string << " #{input}"
    end

    puts calc.evaluate(string)
  end
end

if __FILE__ == $PROGRAM_NAME
  # only run this in program mode
  if ARGV.empty?
    # if no file given, read input from the standard input (console)
    # file
    RPNCalculator.run_ui
  else
    File.open(ARGV[0]) do |file|
      puts RPNCalculator.evaluate_file(file)
    end
  end
end
