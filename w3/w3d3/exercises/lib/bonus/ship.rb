class Ship
  # => Aircraft Carrier: Length = 5
  # => Battleship: Length = 5
  # => Submarine: Length = 4
  # => Destroyer: Length = 3
  # => Patrol Boat: Length = 2
  # Each ship method will take a start position and a direction that
  # the ship will face. The position will be an array ([1, 3])
  # and the position will be the ordinal directions
  # n(orth) s(outh) e(ast) w(est)
  def self.battleship
    Ship.new("Battleship",:b,4)
  end

  def self.aircraft_carrier
    Ship.new("Aircraft Carrier",:a,5)
  end

  def self.submarine
    Ship.new("Submarine",:s,3)
  end

  def self.destroyer
    Ship.new("Destroyer",:d,3)
  end

  def self.patrol_boat
    Ship.new("Patrol Boat",:p,2)
  end
  attr_reader :marker, :name, :length
  attr_accessor :positions

  def initialize(name,marker,length)
    @marker = marker
    @length = length
    @name = name
  end

  def to_s
    @marker.to_s
  end

  def set_position(start,direction)
    row = start[0]
    column = start[1]
    @positions = [start]

    if direction == "n"
      (@length-1).times do
        @positions << [row -= 1, column]
      end
    elsif direction == "e"
      (@length-1).times do 
        @positions << [row, column += 1]
      end
    elsif direction == "s"
      (@length-1).times do 
         @positions << [row += 1, column]
       end
    elsif direction == "w"
      (@length-1).times do 
        @positions << [row, column -= 1]
      end     
    end
  end

end


