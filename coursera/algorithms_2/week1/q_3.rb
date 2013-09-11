require 'set'

input = ARGV[0]

a = Set.new
b = Set.new
e = []

ct = 0
File.open(input) do |f|
  p f.gets
  while line = f.gets
    n1, n2, edge = line.split(" ").map(&:to_i)
    if b.empty?
      b.add(n1)
    else
      a.add(n1)
    end
    a.add(n2)
    e << [edge, n1, n2]
    ct += 1
  end
end

def sort_by_edges(arr)
  arr.sort!{ |a, b| a[0] <=> b[0] }
end

edge_count = 0


while(a.size > 0)
  sort_by_edges(e)
  #p "---"
  #p a
  #p b
  #p e
  index = e.index{ |arr| b.include?(arr[1]) || b.include?(arr[2])}
  #p index
  edge, n1, n2 = e.delete_at(index)
  #p [edge, n1, n2]

  b.add(n1)
  b.add(n2)
  a.delete(n1)
  a.delete(n2)
  edge_count += edge
  #p edge_count
  #p b.size.to_s << " - " << edge_count.to_s << " - " << e.size.to_s

  e.delete_if{ |arr| (b.include?(arr[1]) && b.include?(arr[2])) }
end

p ct
p edge_count
