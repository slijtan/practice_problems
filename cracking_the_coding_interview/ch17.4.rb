class Array
  def my_max
    a = self[0]
    b = self[1]
    diff = a-b

    sign = diff[diff.size*8-1]
    sign_inverted = sign ^ 1

    sign_inverted*a + sign*b
  end
end

class Integer
  def print_binary_string
    p "printing---#{self}"
    (self.size*8 - 1).downto(0) { |i| print self[i] }

    p "last one"
    p self[self.size*8 - 1]
  end
end
