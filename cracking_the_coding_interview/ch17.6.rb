class Array
  def indexes_to_sort
    min_stack = build_min_stack
    max_stack = build_max_stack
    min_index = max_index = nil

    self.each_with_index do |ele, index|
      if(ele == min_stack[-1])
        min_stack.pop
      elsif !min_stack.empty? && ele > min_stack[-1]
        min_index = index
        break
      end
    end

    self.reverse.each_with_index do |ele, index|
      if(ele == max_stack[-1])
        max_stack.pop
      elsif !max_stack.empty? && ele < max_stack[-1]
        max_index = size - index - 1
        break
      end
    end

    min_index ? [min_index, max_index] : nil
  end


  private

  def build_min_stack
    stack = []
    self.reverse_each { |ele| stack << ele if stack.empty? || ele <= stack[-1] }

    stack
  end

  def build_max_stack
    stack = []
    self.each { |ele| stack << ele if stack.empty? || ele >= stack[-1] }

    stack
  end

end
