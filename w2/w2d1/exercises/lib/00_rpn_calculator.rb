
class RPNCalculator
  Operators = [:+,:-,:*,:/]

  def initialize
    @stack = []
  end

  def push(num)
    @stack.push(num.to_f)
  end

  def plus
    operation(:+)
  end

  def minus
    operation(:-)
  end

  def times
    operation(:*)
  end

  def divide
    operation(:/)
  end
  
  def value
    @stack[-1]
  end

  def operation(op_sym)

    calc_error?
    case op_sym
      when :+
       nums = @stack.pop(2)
       @stack.push(nums[0] + nums[1])
      when :-
       nums = @stack.pop(2)
       @stack.push(nums[0]-nums[1])
      when :*
      nums = @stack.pop(2)
       @stack.push(nums[0]*nums[1])
      when :/
       nums = @stack.pop(2)
       @stack.push(nums[0]/nums[1])
    end

  end

  def evaluate(string) #evalues a given expression in RPN form
    expression = tokens(string)#split expression into array (use helper function)

    expression.each do |char|
      if operator?(char)
        operation(char)
      else
        @stack << char
      end
    end
    value
  end

  def tokens(string)
    expression = string.split(" ")
    expression.map {|char| operator?(char) ? char.to_sym : Float(char)}
  end

  def operator?(char)
    Operators.include?(char.to_s.to_sym)
  end

  def calc_error?
    raise "calculator is empty" if @stack.length == 0
  end

  def is_digit?(s)
    Float(s) != nil rescue false
  end
end

puts RPNCalculator.new.evaluate("4 5 -")