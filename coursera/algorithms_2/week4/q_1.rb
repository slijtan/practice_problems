# -*- coding: utf-8 -*-
#In this assignment you will implement one or more algorithms for the all-pairs shortest-path problem. Here are data files describing three graphs: graph #1; graph #2; graph #3.
#
#The first line indicates the number of vertices and edges, respectively. Each subsequent line describes an edge (the first two numbers are its tail and head, respectively) and its length (the third number). NOTE: some of the edge lengths are negative. NOTE: These graphs may or may not have negative-cost cycles.
#
#Your task is to compute the "shortest shortest path". Precisely, you must first identify which, if any, of the three graphs have no negative cycles. For each such graph, you should compute all-pairs shortest paths and remember the smallest one (i.e., compute minu,v∈Vd(u,v), where d(u,v) denotes the shortest-path distance from u to v).
#
#If each of the three graphs has a negative-cost cycle, then enter "NULL" in the box below. If exactly one graph has no negative-cost cycles, then enter the length of its shortest shortest path in the box below. If two or more of the graphs have no negative-cost cycles, then enter the smallest of the lengths of their shortest shortest paths in the box below.



input = ARGV[0]

edges = []
File.open(input) do |f|
  verticies, num_edges = f.gets.chomp.split(" ").map(&:to_i)
  p "processing #{verticies} verts and #{num_edges} edges"

  while line = f.gets
    head, tail, length = line.split(" ").map(&:to_i)
    edges[head] ||= []
    edges[head][tail] = length
    #p "#{head} #{tail} #{length}"
  end

  dp = []

  p "initializing"
  #initialize
  (1..verticies).each do |i|
    dp[i] ||= []

    (1..verticies).each do |j|
      dp[i][j] ||= []

      if i == j
        dp[i][j][0] = 0
      elsif edges[i] && edges[i][j]
        dp[i][j][0] = edges[i][j]
      else
        dp[i][j][0] = Float::INFINITY
      end
    end
  end

  #p dp

  p "finished initializing"
  (1..verticies).each do |k|
    (1..verticies).each do |i|
      (1..verticies).each do |j|
        choice_1 = dp[i][j][k-1]
        choice_2 = dp[i][k][k-1] + dp[k][j][k-1]
        dp[i][j][k] = [choice_1, choice_2].min
      end
    end
  end

  p "finished calculating dp"
  #detect negative cycle
  min_cycle = false
  (1..verticies).each do |i|
    (1..verticies).each do |k|
      min_cycle = true if dp[i][i][k] < 0
    end
  end

  if min_cycle
    p "MIN CYCLE FOUND" and break false
  else
    p "no min cycle found"
  end

  min = Float::INFINITY
  (1..verticies).each do |i|
    (1..verticies).each do |j|
      min = dp[i][j][verticies] if dp[i][j][verticies] < min
    end
  end

  p min
end
