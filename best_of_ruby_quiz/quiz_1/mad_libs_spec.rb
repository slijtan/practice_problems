require File.expand_path(File.dirname(__FILE__) << "/mad_libs.rb")

describe MadLib, "#tell_story" do
  before  do
    word_num = 0
    @stdin = double("stdin")
    @stdin.stub(:gets) { word_num += 1; "word#{word_num}" }
    @stdout = double("stdout")
  end

  context "without reused phrases" do
    before(:all) { @mad_lib = MadLib.new('I had a ((an adjective)) sandwich for lunch today. It dripped all over my ((a body part)) and ((a noun)).') }

    it "prompts the user for input on phrases formatted by ((<phrase>)) and replaces it in the string" do
      @stdout.should_receive(:puts).with("Please provide an adjective")
      @stdout.should_receive(:puts).with("Please provide a body part")
      @stdout.should_receive(:puts).with("Please provide a noun")

      @mad_lib.tell_story(@stdin, @stdout).should == 'I had a word1 sandwich for lunch today. It dripped all over my word2 and word3.'
    end
  end

  context "with reused phrases" do
    before(:all) { @mad_lib = MadLib.new('Our favorite language is ((gem:a gemstone)). We think ((gem)) is better than ((a gemstone)).') }

    it "prompts the user for input on phrases formatted by ((<var>:<phrase>)) and replaces future occurences of ((<var>)) found in string" do
      @stdout.should_receive(:puts).with("Please provide a gemstone")
      @stdout.should_receive(:puts).with("Please provide a gemstone")

      @mad_lib.tell_story(@stdin, @stdout).should == 'Our favorite language is word1. We think word1 is better than word2.'
    end
  end
end
