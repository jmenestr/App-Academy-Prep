def echo(word)
  word
end

def shout(word)
  word.upcase
end

def repeat(word,times = 2)
  Array.new(times,word).join(" ")
end

def start_of_word(word,count)
  word.slice(0...count)
end

def first_word(str)
  str.split(" ").first
end

def titleize(str)
  little_words = %{and the over}
  words = str.split(" ")
  result = words.each_with_index.map do |word,i|
   (i != 0 and little_words.include?(word)) ? word.downcase : word.capitalize
 end

  result.join(" ")
end