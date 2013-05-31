class MyQueue

  def initialize
    @push_stack = []
    @pop_stack = []
  end

  def push(ele)
    shift_to_push_stack
    @push_stack.push(ele)
  end

  def pop
    shift_to_pop_stack
    @pop_stack.pop
  end

  private

  def shift_to_push_stack
    @push_stack.push(@pop_stack.pop) while @pop_stack.size > 0
  end

  def shift_to_pop_stack
    @pop_stack.push(@push_stack.pop) while @push_stack.size > 0
  end
end
