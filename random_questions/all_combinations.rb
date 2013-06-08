#Print all subsets, including empty and full set.
#
#e.g. [1,2,3] => [1,2,3], [1,2], [1,3], [2,3], [1], [2], [3], []

class Array
  def all_subsets
    return [[]] if self.size == 0

    first, rest = self[0], self[1..-1]
    rest = rest.all_subsets
    rest + rest.map {|subset| subset.clone.unshift(first) }
  end
end


p [1,2,3].all_subsets
p [1,2,3,4,5,6,7].all_subsets.size
p [1,2,3,4,5,6,7,8].all_subsets.size
p [1].all_subsets.size
p [1,2].all_subsets.size
p [1,2,3].all_subsets.size

#size complexity of result set is 2^n, where n is size of initial array
