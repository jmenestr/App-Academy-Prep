class Book
  # TODO: your code goes here!
  attr_reader :title
  def title=(name)
    non_caps = %w[the a an and in of]
    words = name.split(" ")
    title = []
    title << words.first.capitalize
    words.drop(1).each do |word|
      new_word = non_caps.include?(word) ? word : word.capitalize
      title << new_word
    end
    @title = title.join(" ")
  end
end
