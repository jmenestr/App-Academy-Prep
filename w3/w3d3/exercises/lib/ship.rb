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
  
  def initalize(name,marker,length)
    @marker = marker
    @length = length
    @name = name
  end

  def to_s
    @marker
  end
  
  def self.battleship(start,direction)
    length = 4
    Ship.position_array(start,length,direction)
  end

  def self.aircraft_carrier(start,direction)
    length = 5
    Ship.position_array(start,length,direction)
  end

  def self.submarine(start,direction)
    length = 3
    Ship.position_array(start,length,direction)
  end

  def self.destroyer(start,direction)
    lenth = 3
    Ship.position_array(start,length,direction)
  end

  def self.patrol_boat(start,direction)
    lenth = 2
    Ship.position_array(start,length,direction)
  end

  def self.position_array(start,length,direction)
    row = start[0]
    column = start[1]
    position_array = [start]

    if direction == "n"
      (length-1).times do
        position_array << [row -= 1, column]
      end
    elsif direction == "e"
      (length-1).times do 
        position_array << [row, column += 1]
      end
    elsif direction == "s"
      (length-1).times do 
         position_array << [row += 1, column]
       end
    elsif direction == "w"
      (length-1).times do 
        position_array << [row, column -= 1]
      end
      
    end
    position_array
  end
end


