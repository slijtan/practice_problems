#!/usr/local/ruby

def split_inversions(left, right)
  i = j = 0
  inv_count = 0

  while i < left.size && j < right.size
    if left[i] < right[j]
      i += 1
    else
      inv_count += left.size - i
      j += 1
    end
  end

  return inv_count
end

def merge_sort(a, b)
  i = j = 0
  res = []

  while i < a.size && j < b.size
    if a[i] < b[j]
      res << a[i]
      i += 1
    else
      res << b[j]
      j += 1
    end
  end

  if i < a.size
    res += a[i..-1]
  else
    res += b[j..-1]
  end

  res
end

def inversions(a)
  return 0, a if a.size == 1

  left_inversions, left_sorted = inversions(a[0...(a.size/2)])
  right_inversions, right_sorted = inversions(a[(a.size/2)..(a.size-1)])

  split_inversions = split_inversions(left_sorted, right_sorted)
  array_sorted = merge_sort(left_sorted, right_sorted)

  total_inv = left_inversions + right_inversions + split_inversions

  return total_inv, array_sorted
end


input = ARGV[0]

a = []
File.open(input) do |f|
  while i = f.gets
    a << i.chomp.to_i
  end
end

p inversions(a).first
