
class RPNCalculator
  Operators = [:+,:-,:*,:/]

  def initialize
    @stack = []
  end

  def push(num)
    @stack.push(num.to_f)
  end

  def plus
    calc_error?
    nums = @stack.pop(2)
    @stack.push(nums[0] + nums[1])
  end

  def minus
    calc_error?
    nums = @stack.pop(2)
    @stack.push(nums[0] - nums[1])
  end

  def times
    calc_error?
    nums = @stack.pop(2)
    @stack.push(nums[0]*nums[1])
  end

  def divide
    calc_error?
    nums = @stack.pop(2)
    @stack.push(nums[0]/nums[1])
  end
  
  def value
    @stack[-1]
  end

  def operation(op_sym)
    operators = [:+,:-,:*,:/]
    case op_sym
      when :+
        plus
      when :-
        minus
      when :*
        times
      when :/
        divide
    end

  end

  def evaluate(expression) #evalues a given expression in RPN form
    tokens(expression)#split expression into array (use helper function)
    while @operands.length > 0 #interate through split expression
      if @operands[0].is_a?(Numeric)#if index is a number, push to stack
        @stack.push(@operands[0])
        @operands.slice!(0)
      else #if index is an operator
        oper = @operands[0]
        @operands.slice!(0)
        operation(oper) #pass correct operation to plus/times/divide/minus methods
      end
    end
    value
  end

  def tokens(expression)
    @operands = expression.split(" ")
    @operands.each_with_index { |item,index|
      if is_digit?(item)
        @operands[index] = item.to_f
      else
        @operands[index] = item.to_sym
      end
    }
  end

  def calc_error?
    raise "calculator is empty" if @stack.length == 0
  end

  def is_digit?(s)
    Float(s) != nil rescue false
  end
end

puts RPNCalculator.new.evaluate("4 5 -")