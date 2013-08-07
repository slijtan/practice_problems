input = ARGV[0]

adj_list = Hash.new {|h, k| h[k] = []}
distances = {1 => 0}

File.open(input) do |f|
  while i = f.gets
    values = i.split(/\s+/)
    node = values.shift.to_i
    values.each do |pair|
      other_node, dist = pair.split(",").map(&:to_i)
      adj_list[node] << [other_node, dist]
    end
  end
end

#p adj_list

while distances.size < adj_list.size
  min_node = nil
  min_dist = nil

  distances.each do |node, d|
    adj_list[node].each do |edge|
      other_node, dist = *edge
      if !distances[other_node] && (min_dist.nil? || min_dist > distances[node] + dist)
        min_dist, min_node = distances[node] + dist, other_node
      end
    end
  end

  distances[min_node] = min_dist
end

p [7,37,59,82,99,115,133,165,188,197].map{|i| distances[i]}.join(",")
