input = ARGV[0]

ints = []
found = {}
matches = {}

File.open(input) do |f|
  while i = f.gets
    i = i.to_i
    unless found[i]
      ints << i.to_i
      found[i] = true
    end
  end
end


#find first index thats >= value
def bsearch(array, value)
  low = 0
  high = array.size - 1
  
  loop do
    mid = (low + high) / 2

    if high <= low
      return false
    elsif array[mid] >= value && (mid == 0 || array[mid-1] < value) #found
      return mid
    elsif array[mid] > value
      high = mid - 1
    else
      low = mid + 1
    end
  end
end

ints.sort!

ints.each do |x|
  c_lower = -10000 - x
  c_upper = 10000 - x

  i = bsearch(ints, c_lower)

  #p "finding all values of #{x}, search for complements in the range #{c_lower} - #{c_upper} starting at index #{i} with value #{i ? ints[i] : 'n/a'}"

  while i && i < ints.size && ints[i] <= c_upper
    if x != ints[i]
      sum = x + ints[i]
      matches[sum] = true
    end
    i += 1
  end
end

p matches.size
