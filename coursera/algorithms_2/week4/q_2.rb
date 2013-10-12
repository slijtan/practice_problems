# -*- coding: utf-8 -*-
#In this assignment you will implement one or more algorithms for the all-pairs shortest-path problem. Here are data files describing three graphs: graph #1; graph #2; graph #3.
#
#The first line indicates the number of vertices and edges, respectively. Each subsequent line describes an edge (the first two numbers are its tail and head, respectively) and its length (the third number). NOTE: some of the edge lengths are negative. NOTE: These graphs may or may not have negative-cost cycles.
#
#Your task is to compute the "shortest shortest path". Precisely, you must first identify which, if any, of the three graphs have no negative cycles. For each such graph, you should compute all-pairs shortest paths and remember the smallest one (i.e., compute minu,v∈Vd(u,v), where d(u,v) denotes the shortest-path distance from u to v).
#
#If each of the three graphs has a negative-cost cycle, then enter "NULL" in the box below. If exactly one graph has no negative-cost cycles, then enter the length of its shortest shortest path in the box below. If two or more of the graphs have no negative-cost cycles, then enter the smallest of the lengths of their shortest shortest paths in the box below.

require 'djikstras'

def inbound_nodes(node, edges)
  edges.each_with_index do |tail, head|

  end
end

def bellman_ford(source, nodes, edges)
  dp = []
  dp[0] = []
  
  #initialize
  nodes.each do |node|
    if node == source
      dp[0][node] = 0
    else
      Float::INFINITY unless 
    end
  end

  #recurrence
  (1...nodes.size).each do |i|
    dp[i] = []
    nodes.each do |node|
      candidate_1 = dp[i-1][node]
      
      candidate_2 = inbound_nodes(node, edges).map do |adj_node, distance|
        dp[i-1][adj_node] + distance
      end.min
      
      dp[i][node] = [candidate_1, candidate_2].min
    end
  end

  return dp[nodes.size - 1]
end

input = ARGV[0]

edges = []
nodes = Set.new

File.open(input) do |f|
  verticies, num_edges = f.gets.chomp.split(" ").map(&:to_i)
  p "processing #{verticies} verts and #{num_edges} edges"

  while line = f.gets
    head, tail, length = line.split(" ").map(&:to_i)
    edges[head] ||= []
    edges[head][tail] = length
    nodes << head
    nodes << tail
    #p "#{head} #{tail} #{length}"
  end

  s = nodes.max + 1
  edges[s] = []
  nodes.each do |node|
    edges[s][node] = 0
  end
  nodes << s

  distances = bellman_ford(s, nodes, edges)
end
