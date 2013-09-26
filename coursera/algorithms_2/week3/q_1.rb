input = ARGV[0]

edges = []
File.open(input) do |f|
  capacity, num_nodes = f.gets.chomp.split(" ").map(&:to_i)
  p "processing knapsock of capacity #{capacity} with #{num_nodes} items"

  items = []

  while line = f.gets
    value, weight = line.split(" ").map(&:to_i)
    items << [value, weight]
  end

  dp = Array.new(items.size + 1) { Array.new(capacity + 1) }

  (0..items.size).each { |i| dp[i][0] = 0 }
  (0..capacity).each { |w| dp[0][w] = 0 }

  (1..items.size).each do |i|
    (1..capacity).each do |w|
      item = items[i - 1]

      comparison_w = w - item[1]

      candidate_1 = dp[i - 1][w]
      candidate_2 = comparison_w < 0 ? 0 : dp[i - 1][comparison_w] + item[0]

      dp[i][w] = [candidate_1, candidate_2].max
    end
  end
  #p dp
  p dp[items.size][capacity]
end
