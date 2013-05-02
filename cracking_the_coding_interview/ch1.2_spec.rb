require File.expand_path(File.dirname(__FILE__) + '/ch1.2')

describe String, "#my_reverse!" do
  it "reverses a string in place" do
    str = "asdf"
    str.my_reverse!
    str.should == "fdsa"
  end

  it "maintains casing of the string" do
    str = "asdfF"
    str.my_reverse!
    str.should == "Ffdsa"
  end
end
