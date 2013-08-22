# -*- coding: utf-8 -*-
#The goal of this problem is to implement the "Median Maintenance" algorithm (covered in the Week 5 lecture on heap applications). The text file contains a list of the integers from 1 to 10000 in unsorted order; you should treat this as a stream of numbers, arriving one #by one. Letting xi denote the ith number of the file, the kth median mk is defined as the median of the numbers x1,…,xk. (So, if k is odd, then mk is ((k+1)/2)th smallest number among x1,…,xk; if k is even, then mk is the (k/2)th smallest number among x1,…,xk.)
#
#In the box below you should type the sum of these 10000 medians, modulo 10000 (i.e., only the last 4 digits). That is, you should compute (m1+m2+m3+⋯+m10000)mod10000.
#
#OPTIONAL EXERCISE: Compare the performance achieved by heap-based and search-tree-based implementations of the algorithm.

require 'rubygems'
require 'algorithms'

min_heap = Containers::MinHeap.new
max_heap = Containers::MaxHeap.new
medians = []


input = ARGV[0]

File.open(input) do |f|
  while i = f.gets
    i = i.to_i
    
    if max_heap.max.nil? 
      max_heap << i
    elsif min_heap.min.nil? || i < min_heap.min
      max_heap << i
    else
      min_heap << i
    end

    while max_heap.size - min_heap.size > 1
      min_heap << max_heap.pop
    end

    while min_heap.size > max_heap.size
      max_heap << min_heap.pop
    end
    
    medians << max_heap.max
  end
end

p medians.reduce(:+) % 10000
