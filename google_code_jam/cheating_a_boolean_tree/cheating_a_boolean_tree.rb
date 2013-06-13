#!/usr/local/ruby
=begin
question: https://code.google.com/codejam/contest/dashboard?c=32001#s=p0
solutions: http://www.go-hero.net/jam/08/solutions/4/1/Ruby

Problem

For this problem we will consider a type of binary tree that we will call a boolean tree. In this tree, every row is completely filled, except possibly the last (deepest) row, and the nodes in the last row are as far to the left as possible. Additionally, every node in the tree will either have 0 or 2 children.

What makes a boolean tree special is that each node has a boolean value associated with it, 1 or 0. In addition, each interior node has either an "AND" or an "OR" gate associated with it. The value of an "AND" gate node is given by the logical AND of its two children's values. The value of an "OR" gate likewise is given by the logical OR of its two children's values. The value of all of the leaf nodes will be given as input so that the value of all nodes can be calculated up the tree.

The root of the tree is of particular interest to us. We would really like for the root to have the value V, either 1 or 0. Unfortunately, this may not be the value the root actually has. Luckily for us, we can cheat and change the type of gate for some of the nodes; we can change an AND gate to an OR gate or an OR gate to an AND gate.

Given a description of a boolean tree and what gates can be changed, find the minimum number of gates that need to be changed to make the value of the root node V. If this is impossible, output "IMPOSSIBLE" (quotes for clarity).
=end

input = ARGV[0]
output = ARGV[1]

File.open(output, 'w') do |fout|
  File.open(input) do |f|

    test_cases = f.gets.chomp.to_i

    1.upto(test_cases) do |c|
      num_nodes, final_val = f.gets.chomp.split(" ").map(&:to_i)
#      p "-----processing test case #{c} with #{num_nodes} nodes and #{final_val} desired result"
      node_data = []
      num_nodes.times { node_data << f.gets.chomp.split(" ").map(&:to_i) }
      dp = []

#      p node_data
      (num_nodes).downto(1) do |i|
#        p dp
#        p "processing node #{i}"
        index, c1_index, c2_index = i - 1, i*2 - 1, i*2

        if node_data[index].size == 1 #leaf node
#          p "leaf node at #{index}"
          dp[index] = node_data[index].first == final_val ? 0 : num_nodes #using num nodes to rep INF, should never be this high anyways...
        else #gate
          if final_val == 1
            if node_data[index].first == 1 #AND
              if node_data[index].last == 1 #is changeable?
                dp[index] = [dp[c1_index] + dp[c2_index], 1 + [dp[c1_index], dp[c2_index]].min].min
              else
                dp[index] = dp[c1_index] + dp[c2_index]
              end
            else #OR
              dp[index] = [dp[c1_index], dp[c2_index]].min
            end
          else
            if node_data[index].first == 1 #AND
              dp[index] = [dp[c1_index], dp[c2_index]].min
            else #OR
              if node_data[index].last == 1 #is changeable?
                dp[index] = [dp[c1_index] + dp[c2_index], 1 + [dp[c1_index], dp[c2_index]].min].min
              else
                dp[index] = dp[c1_index] + dp[c2_index]
              end
            end
          end
        end
      end

#      p dp

      if dp[0] < num_nodes
        fout.puts "Case ##{c}: #{dp[0]}"
        p "Case ##{c}: #{dp[0]}"
      else
        fout.puts "Case ##{c}: IMPOSSIBLE"
        p "Case ##{c}: IMPOSSIBLE"
      end

    end
  end
end
