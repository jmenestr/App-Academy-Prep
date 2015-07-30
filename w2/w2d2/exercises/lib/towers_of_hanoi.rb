# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp/) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

# class TowersOfHanoi

#   def initialize
#     @towers = [
#                 [3,2,1],
#                 [],
#                 []
#               ]
#   end
#   attr_reader :towers

#   def play
#     loop do
#       render
#       break if won?
#       puts "What tower do you want to choose a disk from?"
#       from_tower = gets.chomp.to_i 
#       puts "What tower do you want to move the disk to?"
#       to_tower = gets.chomp.to_i
#       move(from_tower, to_tower) if valid_move?(from_tower, to_tower)
#     end
#   end

#   def won?
#     #Game over if the last tower is the initial state 
#     @towers[1..-1].any? {|tower| tower == [3,2,1]}
#   end

#   def valid_move?(from_tower, to_tower)
#     # Not valid if from_tower is empty
#     # Not valid if to tower is full
#     # Not valid if disk on to_tower is larger than the disk moved from from_tower
#     # Check for bounds of input (tower numbers must in witih range of the length of the array)
#     return false if @towers[from_tower].empty? || (from_tower > 2 or to_tower > 2)
#     return true if @towers[to_tower].empty? || @towers[to_tower].last > @towers[from_tower].last
#     false
#   end

#   def move(from_tower, to_tower)
#     disk = @towers[from_tower].pop
#     @towers[to_tower] << disk

#   end

#   def render
#     system("clear")
#     self.towers.each_with_index do |tower,i|
#       print "Tower #{i}: "
#       tower.each do |disk|
#         print "#{disk} "
#       end
#       print "\n"
#     end
#   end

# end

# require 'byebug'

class TowersOfHanoi

  def initialize(disks = 3, towers = 3)
    @towers = Array.new(towers) {|tower| Array.new}
    @towers[0] = Array.new(disks) {|i| i + 1}.reverse
    @winning_tower = Array.new(disks) {|i| i + 1}.reverse
  end
  attr_reader :towers

  def play
    loop do
      render
      #ßbyebug
      break if won?
      puts "What tower do you want to choose a disk from?"
      from_tower = gets.chomp.to_i 
      puts "What tower do you want to move the disk to?"
      to_tower = gets.chomp.to_i
      move(from_tower, to_tower) if valid_move?(from_tower, to_tower)
    end
  end

  def won?
    #Game over if the last tower is the initial state 
    @towers[0].empty? and @towers[1..-1].any? {|tower| tower == @winning_tower}
  end

  def valid_move?(from_tower, to_tower)
    # Not valid if from_tower is empty
    # Not valid if to tower is full
    # Not valid if disk on to_tower is larger than the disk moved from from_tower
    # Check for bounds of input (tower numbers must in witih range of the length of the array)
    return false if @towers[from_tower].empty? 
    return true if @towers[to_tower].empty? || @towers[to_tower].last > @towers[from_tower].last
    false
  end

  def move(from_tower, to_tower)
    disk = @towers[from_tower].pop
    @towers[to_tower].push(disk)
  end

  def render
    system("clear")
    @towers.each_with_index do |tower,i|
      print "Tower #{i}: "
      tower.each do |disk|
        print "#{disk} "
      end
      print "\n"
    end
  end

end

TowersOfHanoi.new(15,3).play
