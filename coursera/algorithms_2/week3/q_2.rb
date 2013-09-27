input = ARGV[0]

$upper_bounds_cache = []
def upper_bound(items, item_starting_index, capacity)
  $upper_bounds_cache[item_starting_index] ||= []
  return $upper_bounds_cache[item_starting_index][capacity] if $upper_bounds_cache[item_starting_index][capacity]

  weight = capacity
  value = 0
  ratio = 0
  
  (item_starting_index...items.size).each do |i|
    item_value = items[i][0]
    item_weight = items[i][1]

    if item_weight <= weight
      value += item_value
      weight -= item_weight

      if weight == 0
        $upper_bounds_cache[item_starting_index][capacity] = value
        return value 
      end
    else
      ratio = item_value.to_f/item_weight
      value += weight * ratio
      $upper_bounds_cache[item_starting_index][capacity] = value
      return value
    end
  end

  value += ratio * weight
  $upper_bounds_cache[item_starting_index][capacity] = value
  value
end

$cached_calculations = []
$best_value = 0

def optimal_value(items, item_starting_index, weight, value)
#  p "optimal values with #{item_starting_index}, #{weight}"
  if item_starting_index > items.size - 1
    if value > $best_value
      $best_value = value
    end
    return false
  end
  
  optimal_bound = upper_bound(items, item_starting_index, weight)
#  p "#{$best_at_capacity[weight]} vs #{optimal_bound}" unless $best_at_capacity[weight].nil?
  if $best_value > optimal_bound + value
    #p "SKIPPING"
    return false
  end

  new_weight = weight - items[item_starting_index][1]
  new_value = items[item_starting_index][0]
  if new_weight > 0
    optimal_value(items, item_starting_index + 1, new_weight, value + new_value)
  elsif new_weight == 0
    $best_value = new_value + value if new_value + value > $best_value
  else
    $best_value = value if value > $best_value
  end
  optimal_value(items, item_starting_index + 1, weight, value)
  return false
end

File.open(input) do |f|
  capacity, num_nodes = f.gets.chomp.split(" ").map(&:to_i)
  p "processing knapsock of capacity #{capacity} with #{num_nodes} items"

  items = []

  while line = f.gets
    value, weight = line.split(" ").map(&:to_i)
    items << [value, weight]
  end

  items.sort! { |a, b| b[0].to_f/b[1] <=> a[0].to_f/a[1] }

  optimal_value(items, 0, capacity, 0)
end

p $best_value
