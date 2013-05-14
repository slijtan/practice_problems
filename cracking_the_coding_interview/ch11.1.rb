class Array
  def merge_sorted_arrays!(b)
    index_a = index_b = 0
    res = Array.new
    raise Exception "both arguments must be sorted arrays" unless self.is_sorted?  && b.is_sorted?

    while index_a < self.size || index_b < b.size
      if index_a >= self.size
        res << b[index_b]
        index_b += 1

      elsif index_b >= b.size
        res << self[index_a]
        index_a += 1

      elsif self[index_a] < b[index_b]
        res << self[index_a]
        index_a += 1

      else
        res << b[index_b]
        index_b += 1
      end
    end

    self.replace res
  end

  protected

  def is_sorted?
    return true if self.size < 2
    prev_val = self.first

    self.each do |i|
      if i < prev_val
        return false
      else
        prev_val = i
      end
    end

    true
  end
end
