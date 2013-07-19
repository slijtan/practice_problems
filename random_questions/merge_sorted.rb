class Node
  attr_accessor :next, :value

  def initialize(value)
    @value = value
    @next = nil
  end

  def to_s
    str = value.to_s
    node = @next

    while node
      str << node.value.to_s
      node = node.next
    end
    str
  end
end

def mergeLists(list_a, list_b)
  return list_b if list_a.nil?
  return list_a if list_b.nil?

  list_c = nil
  list_c_tail = nil

  while list_a && list_b
    if (list_a.value < list_b.value)
      tmp = list_a
      list_a = tmp.next
      tmp.next = nil
    else
      tmp = list_b
      list_b = tmp.next
      tmp.next = nil
    end

    if list_c.nil?
      list_c = tmp
      list_c_tail = tmp
    else
      list_c_tail.next = tmp
      list_c_tail = list_c_tail.next
    end
  end

  if list_a.nil?
    list_c_tail.next = list_b
  else
    list_c_tail.next = list_a
  end

  list_c
end

n1 = Node.new(1)
n2 = Node.new(2)
n3 = Node.new(3)
n4 = Node.new(4)
n5 = Node.new(5)
n6 = Node.new(6)

n1.next = n2
n2.next = n3

n4.next = n5
n5.next = n6

p "list a: #{list_a}"
p "list b: #{list_b}"

list_c = mergeLists(list_a, list_b)

p "list c: #{list_c}"
