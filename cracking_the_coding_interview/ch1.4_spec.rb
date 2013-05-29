require File.expand_path(File.dirname(__FILE__) + '/ch1.4')

describe String, "#encode_spaces" do
  it "encodes spaces to be %20" do
    str = "this is a string to encode"
    str.encode_spaces
    str.should == "this%20is%20a%20string%20to%20encode"
  end

  it "handles starting and trailing spaces" do
    str = " this is a string to encode "
    str.encode_spaces
    str.should == "%20this%20is%20a%20string%20to%20encode%20"
  end

  it "handles multiple adjacent spaces" do
    str = "this  is a string to encode"
    str.encode_spaces
    str.should == "this%20%20is%20a%20string%20to%20encode"
  end
end
