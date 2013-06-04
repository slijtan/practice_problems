require File.expand_path(File.dirname(__FILE__) + "/ch17.3.rb")

describe Integer, "#factorial_trailing_zeros" do

  it "correctly calculates the number of trailing zeros in a factorial" do
    (1..4).each {|i| i.factorial_trailing_zeros.should == 0}

    5.factorial_trailing_zeros.should == 1
    10.factorial_trailing_zeros.should == 2
    15.factorial_trailing_zeros.should == 3
    16.factorial_trailing_zeros.should == 3
    25.factorial_trailing_zeros.should == 6
  end
end
