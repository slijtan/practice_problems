class Node
  attr_accessor :edges, :value

  def initialize(value)
    @value = value
    @edges = []
  end

  def to_s
    "#{@value} -> #{@edges.join(' ')}"
  end
end

class Edge
  def initialize(from, to)
    @from = from
    @to = to
  end
end

def min_cut(nodes)
  p "."
  while nodes.size > 2
    random_node = nodes[nodes.keys.sample]
    merge_node = nodes[random_node.edges.sample]

    #delete edges between random_node and merge_node
    random_node.edges.delete(merge_node.value)
    merge_node.edges.delete(random_node.value)

    #update all merge_node's edges to be random_node instead
    merge_node.edges.each do |node_id|
      node = nodes[node_id]
      node.edges.map!{ |other_node_id| other_node_id == merge_node.value ? random_node.value : other_node_id }
    end

    #copy all of merge_node's edges into random_node
    random_node.edges.concat(merge_node.edges)

    #remove self referential edges
    random_node.edges.delete(random_node.value)

    #delete merge_node from nodes hash
    nodes.delete(merge_node.value)
  end

#  p nodes
  raise Exception.new("Unbalanced Nodes") if nodes.to_a.first[1].edges.size != nodes.to_a.last[1].edges.size
  nodes.to_a.first[1].edges.size
end


def generate_object_hash(nodes)
  nodes_with_objects = {}

  nodes.each do |from_node_value, to_node_values|
    unless from_node = nodes_with_objects[from_node_value]
      from_node = Node.new(from_node_value)
      nodes_with_objects[from_node_value] = from_node
    end

    to_node_values.each do |to_node_value|
      unless to_node = nodes_with_objects[to_node_value]
        to_node = Node.new(to_node_value)
        nodes_with_objects[to_node_value] = to_node
      end

      from_node.edges << to_node_value
    end

  end

  nodes_with_objects
end


input = ARGV[0]
runs = (ARGV[1] || 20).to_i

nodes = {}
File.open(input) do |f|
  while i = f.gets
    values = i.split(/\s+/).map(&:to_i)
    from_node_value = values.shift

    nodes[from_node_value] ||= []
    nodes[from_node_value].concat(values)
  end
end



min_cuts = runs.times.inject([]) { |a| a << min_cut(generate_object_hash(nodes)) }
p min_cuts
p min_cuts.min
