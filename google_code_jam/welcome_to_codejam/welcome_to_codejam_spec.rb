require File.expand_path(File.join(File.dirname(__FILE__), 'welcome_to_codejam.rb'))

describe String, "#count_substrings_rec" do
  it "solves 1st example" do
    "elcomew elcome to code jam".count_substrings_rec("welcome to code jam").should == 1
  end

  it "solves 2nd example" do
    "wweellccoommee to code qps jam".count_substrings_rec("welcome to code jam").should == 256
  end

  it "solves 3rd example" do
    "welcome to codejam".count_substrings_rec("welcome to code jam").should == 0
  end
end
