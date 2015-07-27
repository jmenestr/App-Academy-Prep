def add(a,b)
  a+b
end

def subtract(a,b)
  a-b
end

def sum(arry)
  arry.inject(0) {|sum,num| sum + num}
end

def multiply(*nums)
  nums.inject(1) {|col, num| col*num}
end

def power(a,b)
  #The easy way is a**b...
  result = 1
  b.times { result *= a }
  result
end

def factorial(num)
  if num == 0
    return 1
  end
  return num*factorial(num-1)
end