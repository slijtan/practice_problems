require File.expand_path(File.dirname(__FILE__) + '/ch18.10.rb')

describe Array, "#evolution" do

  it "transforms the first word into the second" do
    %w{damp like}.evolution.should == %w{damp lamp limp lime like}
  end

  it "checks for only 2 element arrays" do
    expect { %w{a b c}.evolution }.to raise_error(ArgumentError)
  end

  it "both elements must have strings of equal length" do
    expect { %w{a bc}.evolution }.to raise_error(ArgumentError)
  end

end
