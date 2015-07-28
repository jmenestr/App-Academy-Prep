def reverser(&prc)
  words = prc.call
  words = words.split(" ").map{ |word| word.reverse }
  words.join(" ")
end

def adder(add = 1, &prc) 
  prc.call + add
end

def repeater(count = 1,&prc)
  count.times {prc.call}
end