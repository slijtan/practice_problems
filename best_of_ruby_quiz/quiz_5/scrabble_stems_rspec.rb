require File.expand_path(File.join(File.dirname(__FILE__), 'scrabble_stems.rb'))

describe Dictionary, "#scrabble_stems" do
  before do
    @dictionary = Dictionary.new(%w{asteria baiters raciest then than have is a})
  end

  it "finds all scrabble stems with 1 cutoff" do
    @dictionary.scrabble_stems(1).should include("aeirst")
    @dictionary.scrabble_stems(1).should include("aairst")
    @dictionary.scrabble_stems(1).should include("aaerst")
    @dictionary.scrabble_stems(1).should include("aaeist")
    @dictionary.scrabble_stems(1).should include("aaeirt")
    @dictionary.scrabble_stems(1).should include("aaeirs")
  end

  it "finds all scrabble stems with 3 cutoff" do
    @dictionary.scrabble_stems(1).should include("aeirst")
    @dictionary.scrabble_stems(1).should include("aairst")
    @dictionary.scrabble_stems(1).should include("aaerst")
    @dictionary.scrabble_stems(1).should include("aaeist")
    @dictionary.scrabble_stems(1).should include("aaeirt")
    @dictionary.scrabble_stems(1).should include("aaeirs")
  end

  it "finds all scrabble stems with 4 cutoff" do
    @dictionary.scrabble_stems(4).should == []
  end
end
