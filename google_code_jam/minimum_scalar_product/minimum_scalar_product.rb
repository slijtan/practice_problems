=begin
problem: https://code.google.com/codejam/contest/32016/dashboard#s=p0
solutions: http://www.go-hero.net/jam/08/solutions/1/1/Ruby

Problem

You are given two vectors v1=(x1,x2,...,xn) and v2=(y1,y2,...,yn). The scalar product of these vectors is a single number, calculated as x1y1+x2y2+...+xnyn.

Suppose you are allowed to permute the coordinates of each vector as you wish. Choose two permutations such that the scalar product of your two new vectors is the smallest possible, and output that minimum scalar product.
=end

class Array
  def min_scalar_product(b)
    sum = 0
    b.sort!
    sort{ |a,b| b.abs <=> a.abs }.each do |ele|
      if ele > 0
        sum += ele * b.shift
      else
        sum += ele * b.pop
      end
    end

    sum
  end
end
