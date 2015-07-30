class Numeric
  def in_words
    ones = %w{one two three four five six seven eight nine}
    teens = %w{eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen}
    tens = %w{ten twenty thirty forty fifty sixty seventy eighty ninety}
    illions = %w{hundred thousand million billion trillion quadrillion}

    return "zero" if self == 0
    num_str = self.to_s
    groups = []
    until num_str.empty?
      if num_str.length < 3
        groups.unshift(num_str.slice!(-num_str.length..-1))
      else
        groups.unshift(num_str.slice!(-3..-1))
      end
    end
    words = []
    until groups.empty?
      first = groups.shift.to_i
      if first > 0
        if first >= 100
          rem = first/100
          words << ones[rem-1]
          words << illions[0]
          first -= 100*rem
        end
        if first > 19 or first == 10
          rem = first/10
          words << tens[rem-1]
          first -= 10*rem
        end
        if first < 10 and first > 0
          words << ones[first-1]
        end
        if first > 10 and first < 20
          rem = first % 10
          words << teens[rem-1]
        end
        if groups.length > 0
          words << illions[groups.length]
        end
      end
    end
     words.join(" ")
  end

end
puts 1_000.in_words