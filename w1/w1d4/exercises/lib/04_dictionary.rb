class Dictionary
  # TODO: your code goes here!
  attr_reader :entries
  def initialize
    @entries = {}
  end

  def add(entry)
    if entry.is_a?(String)
      @entries[entry] = nil
    elsif entry.is_a?(Hash)
      @entries.merge!(entry)
    end
  end

  def keywords
    @entries.keys.sort
  end

  def include?(entry)
    @entries.keys.include?(entry)
  end

  def find(pattern)
    @entries.select {|key,value| key.match(pattern)}
  end

  def printable
    entries = keywords.map do |key|
       %Q{[#{key}] "#{@entries[key]}"}
    end
    entries.join("\n")
  end
end
