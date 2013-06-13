#!/usr/local/ruby

require File.expand_path(File.join(File.dirname(__FILE__), 'milkshakes.rb'))

input = ARGV[0]
output = ARGV[1]

File.open(output, 'w') do |fout|
  File.open(input) do |f|

    test_cases = f.gets.chomp.to_i

    i.upto(test_cases) do |i|
      "processing test case #{i}"

      num_nodes, final_val = f.gets.chomp.split(" ").map(&:to_i)
      node_data = []
      num_nodes.times { node_data << f.gets.chomp.split(" ").map(&:to_i) }
      dp = []
      (num_nodes.size-1..0).each do |i|
        if node_data[i].size == 1 #leaf node
          dp[i] = node_data.first == final_val ? 0 : num_nodes #using num nodes to rep INF, should never be this high anyways...
        else
          if final_val == 1
            if node_data[i].first == 1 #AND
              if node_data[i].last == 1 #is changeable?
                dp[i] = [dp[i*2] + dp [i*2+1], 1 + [dp[i*2], dp [i*2+1]].min].min
              else
                dp[i] = dp[i*2] + dp [i*2+1]
              end
            else #OR
              dp[i] = [dp[i*2], dp [i*2+1]].min
            end
          else
            if node_data[i].first == 1 #AND
              dp[i] = [dp[i*2], dp [i*2+1]].min
            else #OR
              if node_data[i].last == 1 #is changeable?
                dp[i] = [dp[i*2] + dp [i*2+1], 1 + [dp[i*2], dp [i*2+1]].min].min
              else
                dp[i] = dp[i*2] + dp [i*2+1]
              end
            end
          end
        end
      end

      if dp[0] < num_nodes
        fout.puts "Case ##{i}: #{dp[0]}"
        p "Case ##{i}: #{dp[0]}"
      else
        fout.puts "Case ##{i}: IMPOSSIBLE"
        p "Case ##{i}: IMPOSSIBLE"
      end
    end
  end
end
