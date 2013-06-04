require File.expand_path(File.dirname(__FILE__) + "/ch17.6.rb")

describe Array, "#indexes_to_sort" do
  it "returns bounding indexes of elements that need to be sorted" do
    [1,2,4,7,10,11,7,12,6,7,16,18,19].indexes_to_sort.should == [3, 9]
  end

  it "handles 2 element sorts" do
    [1,2,3,4,10,5,11,12,13,14].indexes_to_sort.should == [4,5]
  end

  it "returns nil if no sorting is required" do
    [1,2,3,4,5].indexes_to_sort.should be_nil
  end

  it "handles arrays with 0, 1 elements" do
    [].indexes_to_sort.should be_nil
    [1].indexes_to_sort.should be_nil
  end

  it "handles sorted arrays with 2 elements" do
    [1,200].indexes_to_sort.should be_nil
  end

  it "handles unsorted arrays with 2 elements" do
    [25,11].indexes_to_sort.should == [0,1]
  end

  it "handles negative numbers" do
    [-10,-9,-8,4,-7,5,-7,14].indexes_to_sort.should == [3,6]
    [-11,-12].indexes_to_sort.should == [0,1]
  end

  it "handles corner sorts" do
    [10,1,2,3,14,15].indexes_to_sort.should == [0, 3]
    [1,2,3,4,5,6,7,14,4].indexes_to_sort.should == [4, 8]
  end
end
