def translate(str)
  words = str.split(" ")
  trlt = words.map {|word| translate_word(word)}
  trlt.join(" ")
end

def translate_word(word)

  vowels = %{a e i o u}
  result = ""

  #Checks for capitilzation  of word and if true, flags 
  if is_cap = capitalized?(word)
    word.downcase!
  end
  #Checks for punc at end of word and if true, flags and saves
  if is_punc = punctuated?(word) 
    punc = word.slice!(-1)
  end

  if vowels.include? word[0]
    #Handles case where firstl letter is a vowel
    result = word + "ay"

  else
    #Handles all other cases where first letter not a vowel
    index = 0
    word.split("").each_with_index do |char,i|
      if char == "q" and word[i+1] == "u"
        index = i + 1
        break
      elsif vowels.include? char
        index = i - 1
        break
      end

    end

    front = word.slice!(0..index)
    result = (word + front + "ay")
  end
  result = is_cap ? result.capitalize : result
  result = is_punc ? result + "#{punc}" : result
end

def capitalized?(word)
  word[0] == word[0].upcase
end

def punctuated?(word)
  punc = %w[, . ! ?]
  if punc.include? word[-1]
    return true
  end
  false
end