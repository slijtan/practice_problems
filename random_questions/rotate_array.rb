class String
  def rotate(num)
    rev_string = self.reverse
    rev_string[0...num] = rev_string[0...num].reverse
    rev_string[num..-1] = rev_string[num..-1].reverse
    rev_string
  end

  def rotate!(num)
    my_reverse
    my_reverse(0, num-1)
    my_reverse(num, self.length - 1)
  end

  def my_reverse(from = 0, to = (self.length - 1))
    ((to-from+1)/2).times do |i|
      self[from+i], self[to-i] = self[to-i], self[from+i]
    end
  end
end



str = "abcdefg"
str.rotate!(3)
p str
