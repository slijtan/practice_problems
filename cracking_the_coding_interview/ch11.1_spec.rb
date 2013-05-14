require File.expand_path(File.dirname(__FILE__) + '/ch11.1')

describe Array, "#merge_sorted_arrays!" do
  it "merges 2 sorted arrays that are overlapping" do
    a = [1,3,5,7,9]
    b = [2,4,6,8,10]

    a.merge_sorted_arrays!(b)

    a.should == [1,2,3,4,5,6,7,8,9,10]
  end

  it "merges 2 sorted arrays that arent overlapping where the 1st is completely before the 2nd" do
    a = [1,2,3,4,5]
    b = [6,7,8,9,10]

    a.merge_sorted_arrays!(b)

    a.should == [1,2,3,4,5,6,7,8,9,10]
  end

  it "merges 2 sorted arrays that arent overlapping where the 2nd is completely before the 1st" do
    a = [6,7,8,9,10]
    b = [1,2,3,4,5]

    a.merge_sorted_arrays!(b)

    a.should == [1,2,3,4,5,6,7,8,9,10]
  end

  it "merges 2 sorted arrays where the first array completely surrounds the 2nd array" do
    a = [1,2,3,9,10]
    b = [4,5,6,7,8]

    a.merge_sorted_arrays!(b)

    a.should == [1,2,3,4,5,6,7,8,9,10]
  end

  it "merges 2 sorted arrays of different sizes" do
    a = [1,2,3,4,5,11,12,15,16,17]
    b = [6,7,8,9,10,13,14]

    a.merge_sorted_arrays!(b)

    a.should == (1..17).to_a
  end

  it "raises an exception if the input arrays arent properly sorted" do
    a = [10,2,3,9]
    b = [4,5,6,7,8]

    lambda { a.merge_sorted_arrays!(b) }.should raise_error
  end
end
