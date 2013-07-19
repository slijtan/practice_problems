def find_missing(a1, a2)
  a1.reduce(:^) ^ a2.reduce(:^)
end

p find_missing([1,2,3,4,5], [1,2,4,5])
