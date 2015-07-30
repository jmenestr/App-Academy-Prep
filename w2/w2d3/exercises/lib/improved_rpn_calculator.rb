require_relative '00_rpn_calculator'
require 'byebug'

if __FILE__ == $PROGRAM_NAME
  calculator = RPNCalculator.new

  if ARGV.length == 1
    file = ARGV[0]
    File.open(file,"r").readlines.each do |expression|
      result = calculator.evaluate(expression)
      puts "#{expression.chomp} = #{result}"
    end
  else
    puts calculator.phrase
  end

end