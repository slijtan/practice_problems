require File.expand_path(File.dirname(__FILE__) << "/ch18.4.rb")

describe Integer, "#smaller_numbers_with_twos" do

  it "returns all smaller numbers with twos for a single digit number" do
    9.smaller_numbers_with_twos.should == [2]
  end

  it "returns all smaller numbers with twos for a double digit number" do
    33.smaller_numbers_with_twos.should == [2,12,20,21,22,23,24,25,26,27,28,29,32]
  end

  it "returns all smaller numbers with twos for a triple digit number" do
    expected = [2,12,20,21,22,23,24,25,26,27,28,29,32,42,52,62,72,82,92,102,112,120,121,122,123,124,125,126,127,128,129,132,142,152,162,172,182,192]
    expected.concat((200..299).to_a)
    expected.concat([302,312,320,321,322,323,324,325,326,327,328,329,332])

    333.smaller_numbers_with_twos.should == expected
  end

  it "handles numbers that are in the middle of a range" do
    25.smaller_numbers_with_twos.should == [2,12,20,21,22,23,24,25]
  end

  it "handles 0" do
    0.smaller_numbers_with_twos.should == []
  end

  it "handles 1" do
    1.smaller_numbers_with_twos.should == []
  end

  it "handles 2" do
    2.smaller_numbers_with_twos.should == [2]
  end

end
