class Array
  def quick_sort!(pivot = :first, first = 0, last = self.size - 1)
    return 0 if last <= first

    #select pivot and swap it into first element
    case pivot
    when :first
    when :last
      self[first], self[last] = self[last], self[first]
    when :median
      f = self[first]
      l = self[last]
      m = self[(last + first) / 2]
      median = ([f,m,l].sort)[1]

      if median == f
        i = first
      elsif median == m
        i = (last + first) / 2
      else
        i = last
      end

      self[first], self[i] = self[i], self[first]
    end

    threshold_ptr = first + 1
    threshold_ptr += 1 while self[threshold_ptr] && self[threshold_ptr] < self[first]

    (threshold_ptr + 1).upto(last) do |i|
      if self[i] < self[first]
        self[threshold_ptr], self[i] = self[i], self[threshold_ptr]
        threshold_ptr += 1
      end
    end

    self[threshold_ptr - 1], self[first] = self[first], self[threshold_ptr - 1]

    return last - first + self.quick_sort!(pivot, threshold_ptr, last) + self.quick_sort!(pivot, first, threshold_ptr - 2)
  end
end


input = ARGV[0]
pivot = ARGV[1] ? ARGV[1].to_sym : :first

a = []
File.open(input) do |f|
  while i = f.gets
    a << i.chomp.to_i
  end
end

p a.quick_sort!(pivot)
