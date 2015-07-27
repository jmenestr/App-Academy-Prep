class Friend
  attr_reader :name

  def initialize(name = "Bob")
    @name = name
  end

  def greeting(name = nil)
    if name
      "Hello, #{name}!"
    else
      "Hello!"
    end
  end
end
