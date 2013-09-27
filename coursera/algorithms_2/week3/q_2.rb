input = ARGV[0]

$cached_calculations = []
def optimal_value(items, item_starting_index, weight)
#  p "optimal values with #{item_starting_index}, #{weight}"
  return 0 if item_starting_index > items.size - 1
  
  $cached_calculations[item_starting_index] ||= []
  
  if $cached_calculations[item_starting_index][weight]
#    p "cached " + $cached_calculations[item_starting_index][weight].to_s
    return $cached_calculations[item_starting_index][weight]
  end
  
  value1 = optimal_value(items, item_starting_index + 1, weight)

  new_weight = weight - items[item_starting_index][1]
  new_value = items[item_starting_index][0]
  if new_weight > 0
    value2 = optimal_value(items, item_starting_index + 1, new_weight) + new_value
    res = [value1, value2].max
  elsif new_weight == 0
    res = [value1, new_value].max
  else
    res = value1
  end

  $cached_calculations[item_starting_index][weight] = res
#  p "new " + $cached_calculations[item_starting_index][weight].to_s
  res
end

File.open(input) do |f|
  capacity, num_nodes = f.gets.chomp.split(" ").map(&:to_i)
  p "processing knapsock of capacity #{capacity} with #{num_nodes} items"

  items = []

  while line = f.gets
    value, weight = line.split(" ").map(&:to_i)
    items << [value, weight]
  end

  p optimal_value(items, 0, capacity)
end
