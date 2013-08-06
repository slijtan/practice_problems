require "benchmark"

input = ARGV[0]

$adj_list = Hash.new {|h, k| h[k] = [[], []]} #zero element is adjacency list, first element is reverse adjacency list

time = Benchmark.realtime do
  File.open(input) do |f|
    while i = f.gets
      values = i.split(" ").map(&:to_i)
      if values[1]
        $adj_list[values[0]][0] << values[1]
        $adj_list[values[1]][1] << values[0]
      end
    end
  end
end

p "#{time} to load data"
#p $adj_list

time = Benchmark.realtime do
  $explored = []
  $ordered_nodes = []

  $adj_list.keys.max.downto($adj_list.keys.min).each do |i|
    next if $explored[i]
    $traversal_stack = [i]
    $explored[i] = true

    while !$traversal_stack.empty?
      unexplored_children = false

      $adj_list[$traversal_stack.last][1].each do |n|
        unless $explored[n]
#          print "c#{n}"
          $traversal_stack << n
          $explored[n] = true
          unexplored_children = true
        end
      end

      unless unexplored_children
        n = $traversal_stack.pop
#        print "e#{n}"
        $ordered_nodes << n
      end
    end
  end
end

p "#{time} to do first pass bfs"
#p $ordered_nodes
$explored = []
$scc_sizes = []

time = Benchmark.realtime do
  while i = $ordered_nodes.pop
    next if $explored[i]
    scc_size = 0
    $traversal_stack = [i]
    $explored[i] = true

    while !$traversal_stack.empty?
      unexplored_children = false

      $adj_list[$traversal_stack.last][0].each do |n|
        unless $explored[n]
#          print "c#{n}"
          $traversal_stack << n
          $explored[n] = true
          unexplored_children = true
        end
      end

      unless unexplored_children
        n = $traversal_stack.pop
#        print "e#{n}"
        scc_size += 1
      end
    end

#    p "scc for #{i} is #{scc_size}"
    $scc_sizes << scc_size
  end
end

p "#{time} to do second pass bfs"

time = Benchmark.realtime { $scc_sizes.sort! }
p "#{time} to sort results"

p ($scc_sizes.length > 5 ? $scc_sizes[-5, 5] : $scc_sizes).reverse.join(",")
