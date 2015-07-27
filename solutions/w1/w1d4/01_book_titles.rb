class Book
  LOWER_WORDS = [
    "the",
    "a",
    "an",
    "and",
    "in",
    "of"
  ]

  attr_reader :title

  def title=(title)
    title_words = title.split(" ").map(&:downcase)

    new_words = title_words.map.with_index do |word, i|
      if LOWER_WORDS.include?(word) && i != 0
        word
      else
        word.capitalize
      end
    end

    @title = new_words.join(" ")
  end
end
