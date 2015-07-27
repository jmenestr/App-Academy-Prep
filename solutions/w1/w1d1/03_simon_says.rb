def echo(string)
  string
end

def shout(string)
  string.upcase
end

def repeat(string, times = 2)
  words = Array.new(times, string)
  words.join(" ")
end

def start_of_word(word, count)
  word[0...count]
end

def first_word(sentence)
  words = sentence.split(" ")
  words.first
end

LITTLE_WORDS = [
  "and",
  "the",
  "over"
]

def titleize(title)
  words = title.split(" ")
  titleized_words = words.map.with_index do |word, i|
    if i != 0 && LITTLE_WORDS.include?(word)
      word.downcase
    else
      word.capitalize
    end
  end

  titleized_words.join(" ")
end
