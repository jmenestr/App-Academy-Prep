def add(x, y)
  x + y
end

def subtract(x, y)
  x - y
end

def sum(numbers)
  sum = 0
  numbers.each { |number| sum += number }
  sum
end

# Alternative using #inject
# def sum(numbers)
#   numbers.inject(&:+)
# end

def multiply(*numbers)
  product = 1
  numbers.each { |number| product *= number }
  product
end

def power(base, exponent)
  base ** exponent
end

def factorial(n)
  return 1 if n == 0
  product = 1
  n.downto(1).each { |num| product *= num }
  product
end
