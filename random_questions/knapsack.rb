#!/usr/bin/ruby
#google for 0/1 knapsack problem to find problem
#TODO: memoize this to make it perform better. Right now its exponential, which is bad...

class KnapObj
  attr_reader :w, :v

  def initialize(w, v)
    @w = w
    @v = v
  end
end

def maximize(set, weight)
  return 0 if set.empty?
  item = set.shift

  if(item.w <= weight)
    with_self = item.v + maximize(set.clone, weight - item.w)
    without_self = maximize(set.clone, weight)

    return [with_self, without_self].max
  else
    return maximize(set, weight)
  end
end

a = KnapObj.new(3,5)
b = KnapObj.new(2,3)
c = KnapObj.new(1,4)

p maximize([b,c], 2)
p maximize([a,b,c], 5)
