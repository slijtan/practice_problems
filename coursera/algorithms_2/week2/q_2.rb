require './union_find.rb'

def merge_nodes_within_2(nodes, key, node_id, uf, length)
  find_nodes_within_2(nodes, key, length).each do |node_2_id|
    uf.union(node_id, node_2_id)
  end
end

def find_nodes_within_2(nodes, key, length)
  found_nodes = nodes[key]
  #p "======== finding for #{key.to_s(2)}"
  
  (0...length).each do |i|
    outer_search_key = key ^ (1 << i)
    #p "looking for #{outer_search_key.to_s(2)} shifted #{i}"
    if found_key = nodes[outer_search_key]
      #p "found at #{found_key}!"
      found_nodes += found_key
    end
    
    ((i+1)...length).each do |j|
      inner_search_key = outer_search_key ^ (1 << j)
      #p "looking for #{inner_search_key.to_s(2)} shifted #{i}, #{j}"

      if found_key = nodes[inner_search_key]
        #p "found at #{found_key}!"
        found_nodes += found_key
      end
    end
  end

  #p found_nodes
  found_nodes
end

input = ARGV[0]

nodes = {}
uf = UnionFind.new
count = 0
node_count, length = 0, 0

File.open(input) do |f|
  node_count, length = f.gets.split(" ").map(&:to_i)
  p node_count, length

  while line = f.gets
    count += 1
    int_val = line.gsub(" ", "").to_i(2)
    p "#{count}, #{int_val}"

    nodes[int_val] ||= []
    nodes[int_val] << count

    uf << count
  end
end

#p nodes

progress = 0
nodes.each do |key, node_ids|
  node_ids.each do |node_id|
    progress += 1
    p progress
    merge_nodes_within_2(nodes, key, node_id, uf, length)
  end
end

p uf.clusters
