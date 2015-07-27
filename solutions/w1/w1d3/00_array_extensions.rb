class Array
  def sum
    sum = 0
    each { |el| sum += el }
    sum
  end

  def sum
    # Alternative using inject
    inject(0) { |sum, el| sum + el }
  end

  def square!
    each_index { |i| self[i] = self[i] * self[i] }
    self
  end

  def square!
    # Alternative using map
    map! { |el| el * el }
  end

  def square
    dup.square!
  end

  def my_uniq
    uniq_array = []

    self.each do |el|
      uniq_array << el unless uniq_array.include?(el)
    end

    uniq_array
  end

  # Alternatively with inject:
  #
  # def my_uniq
  #   self.inject([]) do |uniq_array, el|
  #     uniq_array << el unless uniq_array.include?(el)
  #     uniq_array
  #   end
  # end

  def two_sum
    pairs = []

    self.count.times do |i1|
      (i1 + 1).upto(self.count - 1) do |i2|
        pairs << [i1, i2] if self[i1] + self[i2] == 0
      end
    end

    pairs
  end

  def my_transpose
    dimension = self.first.count
    cols = Array.new(dimension) { Array.new(dimension) }

    dimension.times do |i|
      dimension.times do |j|
        cols[j][i] = self[i][j]
      end
    end

    cols
  end

  def median
    return nil if empty?
    sorted = self.sort
    if length.odd?
      sorted[length / 2]
    else
      (sorted[length / 2] + sorted[length / 2 - 1]).fdiv(2)
    end
  end
end
