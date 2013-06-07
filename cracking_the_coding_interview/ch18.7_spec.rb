require File.expand_path(File.dirname(__FILE__) + '/ch18.7.rb')

describe Array, "#size_of_longest_made_of_others" do
  it "finds the longest string composed of other words in the array" do
    %w{cat banana dog nana walk catwalk walker dogwalker}.size_of_longest_made_of_others.should == "dogwalker"
  end
end
