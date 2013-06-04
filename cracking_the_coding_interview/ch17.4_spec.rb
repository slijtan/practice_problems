require File.expand_path(File.dirname(__FILE__) + '/ch17.4.rb')

describe Array, "#my_max" do
  it "calculates the max of 2 positive numbers" do
    [10,2].my_max.should == 10
    [10,3].my_max.should == 10
    [10,7].my_max.should == 10
  end

  it "calculates the max of 2 positive numbers that have reversed order" do
    [2,10].my_max.should == 10
    [3,10].my_max.should == 10
    [7,10].my_max.should == 10
  end

  it "calculates the max of a positive and negative number" do
    [2,-10].my_max.should == 2
    [-13,10].my_max.should == 10
    [-7,10].my_max.should == 10
  end

  it "calculates the max of two negative numbers" do
    [-2,-10].my_max.should == -2
    [-13,-10].my_max.should == -10
    [-7,-10].my_max.should == -7
  end

  it "calculates the max of a number and zero" do
    [0, 10].my_max.should == 10
    [0, -5].my_max.should == 0
  end
end
