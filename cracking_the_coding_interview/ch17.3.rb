class Integer

  def factorial_trailing_zeros
    factorial = (1..self).inject(1) {|i, j| i*j}

    count = 0
    while factorial % 10 == 0
      count += 1
      factorial /= 10
    end

    count
  end

end
