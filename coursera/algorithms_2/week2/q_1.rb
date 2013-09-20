require './union_find.rb'

input = ARGV[0]

edges = []
uf = UnionFind.new

File.open(input) do |f|
  p "processing #{f.gets.chomp} nodes"

  while line = f.gets
    n1, n2, length = line.split(" ").map(&:to_i)
    uf << n1
    uf << n2
    edges << [length, n1, n2]
  end
end

edges.sort! { |a, b| a[0] <=> b[0] }

edges.each do |edge|
  n1, n2, length = edge[1], edge[2], edge[0]
  
  if uf.clusters == 4
    if !uf.connected?(n1, n2)
      p edge[0] and break
    end
  elsif !uf.connected?(n1, n2)
    uf.union(n1, n2)
  end
end
