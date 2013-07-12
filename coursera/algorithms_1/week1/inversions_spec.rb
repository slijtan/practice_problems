require File.expand_path(File.join(File.dirname(__FILE__), "inversions.rb"))

describe "#inversions" do
  it "calculates inversions" do
    inversions([3,2,1,4,6,7]).first.should == 3
    inversions([1,4,6,7,9]).first.should == 0
    inversions([9,1,4,6,7]).first.should == 4
  end
end
