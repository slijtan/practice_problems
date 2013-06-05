class Integer

  def smaller_numbers_with_twos
    factor = 1
    n = self
    res = []

    while n > 0
      m = 2 * factor
      jump = 10 * factor
      range = factor

      while m <= self
        range.times do |i|
          candidate = m + i
          res << candidate unless res.include?(candidate)
          break if candidate == self
        end
        m += jump
      end

      factor *= 10
      n /= 10
    end

    res.sort
  end

end
