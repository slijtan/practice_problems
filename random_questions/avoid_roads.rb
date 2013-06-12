=begin
http://community.topcoder.com/stat?c=problem_statement&pm=1889&rd=4709
In the city, roads are arranged in a grid pattern. Each point on the grid represents a corner where two blocks meet. The points are connected by line segments which represent the various street blocks. Using the cartesian coordinate system, we can assign a pair of integers to each corner as shown below.

You are standing at the corner with coordinates 0,0. Your destination is at corner width,height. You will return the number of distinct paths that lead to your destination. Each path must use exactly width+height blocks. In addition, the city has declared certain street blocks untraversable. These blocks may not be a part of any path. You will be given a String[] bad describing which blocks are bad. If (quotes for clarity) "a b c d" is an element of bad, it means the block from corner a,b to corner c,d is untraversable. For example, let's say
width  = 6
length = 6
bad = {"0 0 0 1","6 6 5 6"}
The picture below shows the grid, with untraversable blocks darkened in black. A sample path has been highlighted in red.

Definition

Class:	AvoidRoads
Method:	numWays
Parameters:	int, int, String[]
Returns:	long
Method signature:	long numWays(int width, int height, String[] bad)
(be sure your method is public)


Constraints
-	width will be between 1 and 100 inclusive.
-	height will be between 1 and 100 inclusive.
-	bad will contain between 0 and 50 elements inclusive.
-	Each element of bad will contain between 7 and 14 characters inclusive.
-	Each element of the bad will be in the format "a b c d" where,
a,b,c,d are integers with no extra leading zeros,
a and c are between 0 and width inclusive,
b and d are between 0 and height inclusive,
and a,b is one block away from c,d.
-	The return value will be between 0 and 2^63-1 inclusive.
=end

class AvoidRoads
  DIRECTION_UP = 0
  DIRECTION_RIGHT = 1

  def initialize(w, h, blocked_roads)
    @w = w
    @h = h
    @blocked_roads = blocked_roads.map{|b| BlockedRoad.new(b.chomp)}
  end

  def num_ways
    return 0 if @w == 0 && @h == 0
    nodes = {}

    #initialize nodes
    0.upto(@w) do |x|
      0.upto(@h) do |y|
        nodes["#{x},#{y}"] = Node.new(x, y)
      end
    end

    #load block data into nodes
    @blocked_roads.each do |road|
      x, y = road.leads_to
      nodes["#{x},#{y}"].set_roadblock_from(road.direction)
    end

    dp = []
    ready_nodes = [nodes["0,0"]]

    while node = ready_nodes.pop
      dp[node.x] ||= []
      paths_from_left = node.has_left? ? dp[node.x-1][node.y] : 0
      paths_from_bottom = node.has_bottom? ? dp[node.x][node.y-1] : 0
      dp[node.x][node.y] = node.x == 0 && node.y == 0 ? 1 : paths_from_left + paths_from_bottom #special case for root node

      if node.x+1 <= @w
        right_node = nodes["#{node.x+1},#{node.y}"]
        right_node.visited_from_left = true unless right_node.blocked_from_left
        ready_nodes << right_node if right_node.visited_from_all_possible_sides?
      end
      if node.y+1 <= @h
        top_node = nodes["#{node.x},#{node.y+1}"]
        top_node.visited_from_bottom = true unless top_node.blocked_from_bottom
        ready_nodes << top_node if top_node.visited_from_all_possible_sides?
      end
    end

    dp[@w][@h]
  end

  class BlockedRoad
    def initialize(coordinates)
      @x1, @y1, @x2, @y2 = coordinates.split(" ")

      @x1,@y1,@x2,@y2 = @x2,@y2,@x1,@y1 if(@x1 > @x2 || @y1 > @y2)
    end

    #no error checking to make sure roads only traverse one edge
    def direction
      @x1 != @x2 ? AvoidRoads::DIRECTION_RIGHT : AvoidRoads::DIRECTION_UP
    end

    def leads_to
      [@x2,  @y2]
    end
  end

  class Node
    attr_accessor :visited_from_left, :visited_from_bottom, :blocked_from_left, :blocked_from_bottom
    attr_reader :x, :y

    def initialize(x,y)
      @x, @y = x, y
      @visited_from_left = false
      @visited_from_bottom = false
      @blocked_from_left = x == 0 ? true : false
      @blocked_from_bottom = y == 0 ? true : false
    end

    def visited_from_all_possible_sides?
      (@blocked_from_left || @visited_from_left) && (@blocked_from_bottom || @visited_from_bottom)
    end

    def has_left?
      !@blocked_from_left
    end

    def has_bottom?
      !@blocked_from_bottom
    end

    def set_roadblock_from(direction)
      case direction
      when AvoidRoads::DIRECTION_RIGHT
        @blocked_from_left = true
      when AvoidRoads::DIRECTION_UP
        @blocked_from_bottom = true
      end
    end
  end
end

RSpec.configure do |c|
  c.filter_run_excluding :skip => true
end

describe AvoidRoads, "#numWays" do
  it "calculates the number of paths from corner to corner, given blocks" do
    AvoidRoads.new(6, 6, ["0 0 0 1","6 6 5 6"]).num_ways.should == 252
  end

  it "handles 1x1 maps" do
    AvoidRoads.new(1, 1, []).num_ways.should == 2
  end

  it "handles big numbers" do
    AvoidRoads.new(35, 31, []).num_ways.should == 6406484391866534976
  end

  it "handles no paths" do
    AvoidRoads.new(2, 2, ["0 0 1 0", "1 2 2 2", "1 1 2 1"]).num_ways.should == 0
  end
end
