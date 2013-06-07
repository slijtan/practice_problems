class Array
  def evolution
    a = self[0]
    b = self[1]
    dict = {"damp" => true, "lamp" => true, "limp" => true,  "lime" => true, "like" => true}
    res = [a]
    available_chars = (0...(b.length)).to_a.inject([]){|a, i| a << true}

    raise ArgumentError.new("strings must be the same length") unless a.length == b.length
    raise ArgumentError.new("array must only have 2 elements") unless length == 2

    next_available_char_index(available_chars) do |index|
      candidate = copy_char(a, b, index)

      if dict[candidate]
        a = candidate
        res << a
        available_chars[index] = false
      end
    end

    res
  end

  private

  def copy_char(a, b, index)
    tmp = a.clone
    tmp[index] = b[index]
    tmp
  end

  def next_available_char_index(available_chars, &block)
    last_true_index = available_chars.size - 1
    index = 0
    while true
      if available_chars[index]
        yield index
        last_true_index = index
      else
        return if last_true_index == index
      end

      index = (index + 1) % available_chars.size
    end
  end
end
