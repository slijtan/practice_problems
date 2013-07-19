class StackException < StandardError; end

class Stack
  def initialize
    @data = []
    @ele_count = 0
  end

  def push(number)
    @data[@ele_count] = number
    @ele_count += 1
  end

  def pop
    raise StackException if @ele_count == 0
    ele = @data[@ele_count - 1]
    @ele_count -= 1
    ele
  end

  def peek
    @ele_count == 0 ? false : @data[@ele_count - 1]
  end

  def empty?
    @ele_count == 0
  end
end
