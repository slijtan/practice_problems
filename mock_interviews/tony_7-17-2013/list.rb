class ListException < StandardError; end

class List

  def initialize
    @data = []
  end

  def add(number)
    @data << number
  end

  def get(index)
    data_index = 0
    valid_ele_count = 0

    while valid_ele_count < index + 1
      valid_ele_count += 1 if @data[data_index]
      data_index += 1
    end

    raise ListException.new unless @data[data_index-1]
    @data[data_index-1]
  end

  def empty?
    !@data[0]
  end

  def remove(index)
    element = self.get(index)
    @data[index] = nil
    element
  end

end

describe List do
  let(:list) { List.new }

  it "should add and retrieve a number" do
    list.add(1)
    list.get(0).should == 1

    list.add(2)
    list.get(0).should == 1
    list.get(1).should == 2
  end

  it "should be empty when there is no data" do
    list.should be_empty
  end

=begin
  it "should raise exception if element at index doesn't exist" do
    expect {list.get(0)}.to raise_error(ListException)
  end
=end

  context "list with data" do
    let(:list) do
      list = List.new
      list.add(1)
      list
    end

    it "should not be empty" do
      list.should_not be_empty
    end

    it "should remove an element at index and return it" do
      list.remove(0).should == 1
      list.should be_empty
    end

    it "should get next element after previous elements have been removed" do
      list.add(2)
      list.remove(0)
      list.get(0).should == 2
    end
  end

end
