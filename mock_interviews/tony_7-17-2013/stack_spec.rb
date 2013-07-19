require File.expand_path(File.join(File.dirname(__FILE__), 'stack.rb'))

describe Stack do
  let(:stack) { Stack.new }

  it "should push and pop a number" do
    stack.push(1)
    stack.pop.should == 1
  end

  context "stack with no data" do
    it "should be empty" do
      stack.should be_empty
    end

    it "should raise an exception when poping" do
      expect {stack.pop}.to raise_error(StackException)
    end

    it "should return false on peek" do
      stack.peek.should be_false
    end
  end

  context "stack with data" do
    let(:stack) do
      stack = Stack.new
      stack.push(1)
      stack.push(2)
      stack
    end

    it "should not be empty" do
      stack.should_not be_empty
    end

    it "should be pop the last number that was pushed" do
      stack.pop.should == 2
    end

    it "should pop the most recently pushed number" do
      stack.pop.should == 2
      stack.pop.should == 1
    end

    it "should return last pushed number on peek" do
      stack.peek.should == 2
    end

    it "should not remove last pushed number on peek" do
      stack.peek
      stack.pop.should == 2
    end
  end
end
