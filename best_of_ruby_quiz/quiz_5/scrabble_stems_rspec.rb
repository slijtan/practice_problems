require File.expand_path(File.join(File.dirname(__FILE__), 'scrabble_stems.rb'))

describe Dictionary, "#scrabble_stems" do
  before do
    @dictionary = Dictionary.new(%w{asteria baiters raciest then than have is a})
  end

  it "finds all scrabble stems with 1 cutoff" do
    stems = @dictionary.scrabble_stems(1)
    stems.size.should == 18
    stems.should include("aeirst")
    stems.should include("aairst")
    stems.should include("aaerst")
    stems.should include("aaeist")
    stems.should include("aaeirt")
    stems.should include("aaeirs")
    stems.should include("aaeirs")
  end

  it "finds all scrabble stems with 3 cutoff" do
    stems = @dictionary.scrabble_stems(3)
    stems.size.should == 1
    stems.should == ["aeirst"]
  end

  it "finds all scrabble stems with 4 cutoff" do
    @dictionary.scrabble_stems(4).should == []
  end
end
