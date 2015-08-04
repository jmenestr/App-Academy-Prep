 require_relative "maze_solver"
 require 'byebug'
class MazeGenerator
  def initialize(width,height,options = {})
    @width = width
    @height = height
    @start_x = Random.rand(width)
    @start_y = 0
    @end_x = Random.rand(width)
    @end_y = height - 1
    @horizontal_walls = Grid.new(width,height,true)
    @vertical_walls = Grid.new(width,height,true)
    @visited = Grid.new(width,height)

    @default = {start: "S", finish: "E"}
    @options = @default.merge(options)

    @horizontal_walls[@end_x,@end_y] = false

    generate_maze
  end

  def print
    puts @width.times.inject("+") {|str,x| str << (x == @start_x ?  "-#{@options[:start]}+" : "--+")}
    (@height).times do |y|
      puts @width.times.inject("|") { |str,x| str << "  " + (@vertical_walls[x,y] ? "|" : " ")}    
      if y == @height-1
        puts @width.times.inject("+") {|str,x| str <<  (@horizontal_walls[x,y] ? "--+" : "-#{@options[:finish]}+")}
      else
        puts @width.times.inject("+") {|str,x| str <<  (@horizontal_walls[x,y] ? "--+" : "  +")}
      end
    end
  end

  def file
    file = "maze-#{Random.rand(100)}.txt"
    File.open(file,"w") do |f|
      f.puts @width.times.inject("+") {|str,x| str << (x == @start_x ?  "-#{@options[:start]}+" : "--+")}
      @height.times do |y|
        f.puts @width.times.inject("|") { |str,x| str << "  " + (@vertical_walls[x,y] ? "|" : " ")}
        if y == @height - 1
          f.puts @width.times.inject("+") {|str,x| str <<  (@horizontal_walls[x,y] ? "--+" : "#{@options[:finish]}-+")}
        else
          f.puts @width.times.inject("+") {|str,x| str <<  (@horizontal_walls[x,y] ? "--+" : "  +")}
        end
      end
      file
    end

  end

  def generate_maze
    new_visit(@start_x,@start_y)
  end

  def new_visit(x,y)
    
    @visited[x,y] = true
    get_moves(x,y).shuffle.each do |new_x,new_y|
      next unless valid_visit?(new_x,new_y)    
      connect_cells(x,y,new_x,new_y)
      new_visit(new_x,new_y)
    end
  end

  def connect_cells(x,y,new_x,new_y)
    #above each other -> remove horizontal wall
    if x == new_x
      @horizontal_walls[x,[y,new_y].min] = false
    else
      #next to each other -> remove vertical wall
      @vertical_walls[[x,new_x].min,y] = false
    end
  end

  def valid_visit?(x,y)
    
    @visited.is_inside?(x,y) and @visited[x,y].nil?
  end

  def get_moves(x,y)
    delta = [[1,0],[-1,0],[0,1],[0,-1]]
    delta.map{ |dx,dy| [x + dx, y + dy]}
  end

end

class Grid
  def initialize(width,height,default = nil)
    @width = width
    @height = height
    @grid = Array.new(height) {Array.new(width,default)}
  end

  def [](x,y)
    @grid[y][x]
  end

  def []=(x,y,marker)
    @grid[y][x] = marker
  end

  def is_inside?(x,y)
    x >= 0 and y >= 0 and x < @width and y < @height
  end
end

MazeGenerator.new(20,20).file