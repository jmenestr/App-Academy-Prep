class Temperature
  # TODO: your code goes here!
  def initialize(options)
    if options.has_key?(:f)
      @far = options[:f]
      @cel = ftoc
    else
      @cel = options[:c]
      @far = ctof
    end
  end

  def in_fahrenheit
    @far
  end

  def in_celsius
    @cel
  end

  def self.from_fahrenheit(temp)
    self.new(f: temp)
  end

  def self.from_celsius(temp)
    self.new(c: temp)
  end

  private
    def ftoc
      (@far - 32.0).to_f * 5.0/9
    end

    def ctof
       (@cel.to_f*9.0/5) + 32.0
    end
end

class Fahrenheit < Temperature
  def initialize(temp)
    @far = temp
    @cel = ftoc
  end
end

class Celsius < Temperature
  def initialize(temp)
    @cel = temp
    @far = ctof
  end
end
