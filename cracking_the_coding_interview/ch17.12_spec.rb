require File.expand_path(File.dirname(__FILE__) + '/ch17.12.rb')

describe Array, "#pairs_that_add_up_to" do
  it "returns an array of pairs that add up to the specified sum" do
    result = [1,2,3,4,5,6].pairs_that_add_up_to(5)
    result.size.should == 2

    result.should satisfy{|r| r.include?([1,4]) || r.include?([4,1]) }
    result.should satisfy{|r| r.include?([2,3]) || r.include?([3,2]) }
  end

  it "only returns one pair for a number with duplicate compliments" do
    result = [1,2,3,4,5,6,1].pairs_that_add_up_to(5)
    result.size.should == 2

    result.should satisfy{|r| r.include?([1,4]) || r.include?([4,1]) }
    result.should satisfy{|r| r.include?([2,3]) || r.include?([3,2]) }
  end

  it "returns two pairs for two of the same number with two matching compliments" do
    result = [1,2,3,4,5,6,1,4].pairs_that_add_up_to(5)
    result.size.should == 3

    result.should satisfy{|r| r.include?([1,4]) || r.include?([4,1]) }
    result.delete([1,4]) unless result.delete([4,1])
    result.should satisfy{|r| r.include?([1,4]) || r.include?([4,1]) }
    result.should satisfy{|r| r.include?([2,3]) || r.include?([3,2]) }
  end

  it "handles a negative and positive number" do
    result = [-1,2,3,4,5,6].pairs_that_add_up_to(5)
    result.size.should == 2

    result.should satisfy{|r| r.include?([-1,6]) || r.include?([6,-1])}
  end

  it "handles two negative numbers" do
    result = [-1,-2,3,4,5,6].pairs_that_add_up_to(-3)
    result.size.should == 1

    result.should satisfy{|r| r.include?([-1,-2]) || r.include?([-2,-1])}
  end

  it "raises an error if the size of the array is less than 2" do
    expect {[1].pairs_that_add_up_to(3)}.to raise_error(ArgumentError)

  end
end
