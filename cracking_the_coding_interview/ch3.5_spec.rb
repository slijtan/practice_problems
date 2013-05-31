require File.expand_path(File.dirname(__FILE__) + '/ch3.5.rb')

describe MyQueue do
  before { @my_queue = MyQueue.new }

  it "pushes and then pops FIFO" do
    @my_queue.push(1)
    @my_queue.push(2)
    @my_queue.push(3)
    @my_queue.push(4)
    @my_queue.push(5)

    @my_queue.pop.should == 1
    @my_queue.pop.should == 2
    @my_queue.pop.should == 3
    @my_queue.pop.should == 4
    @my_queue.pop.should == 5
  end

  it "interleaves pushing and popping properly" do
    @my_queue.push(1)
    @my_queue.push(2)
    @my_queue.pop.should == 1
    @my_queue.push(3)
    @my_queue.pop.should == 2
    @my_queue.push(4)
    @my_queue.pop.should == 3
    @my_queue.push(5)
    @my_queue.pop.should == 4
    @my_queue.pop.should == 5
  end

  it "returns nil on empty pop" do
    @my_queue.pop.should be_nil

    @my_queue.push(1)
    @my_queue.pop

    @my_queue.pop.should be_nil
  end

end
