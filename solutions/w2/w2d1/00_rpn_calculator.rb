class RPNCalculator
  OPERATORS = [:+, :-, :*, :/]

  def initialize
    @stack = []
  end

  def divide
    perform_op(:/)
  end

  def evaluate(string)
    tokens(string).each do |token|
      case token
      when Integer
        push(token)
      when Symbol
        perform_op(token)
      end
    end

    value
  end

  def minus
    perform_op(:-)
  end

  def plus
    perform_op(:+)
  end

  def push(num)
    @stack << num
  end

  def times
    perform_op(:*)
  end

  def tokens(string)
    chars = string.split(" ")
    chars.map { |char| operator?(char) ? char.to_sym : Integer(char) }
  end

  def value
    @stack.last
  end

  private
  def operator?(char)
    OPERATORS.include?(char.to_sym)
  end

  def perform_op(op_sym)
    raise "calculator is empty" unless @stack.count >= 2

    right_operand = @stack.pop
    left_operand = @stack.pop

    case op_sym
    when :+
      @stack << left_operand + right_operand
    when :-
      @stack << left_operand - right_operand
    when :*
      @stack << left_operand * right_operand
    when :/
      # `Fixnum#fdiv` is like `/` but makes sure not to round down.
      @stack << left_operand.fdiv(right_operand)
    else
      @stack << left_op << right_op
      raise ArgumentError.new("No operation #{op_sym}")
    end

    self
  end
end
