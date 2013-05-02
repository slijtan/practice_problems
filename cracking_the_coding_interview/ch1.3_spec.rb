require File.expand_path(File.dirname(__FILE__) + '/ch1.3')

describe "#is_perm?" do
  it "checks for exact matches" do
    is_perm?("asdf", "asdf").should be_true
  end

  it "checks for exact character counts" do
    is_perm?("asdf", "fdsa").should be_true
  end

  it "checks for substrings" do
    is_perm?("sdfa", "asdfa").should be_true
  end

  it "checks for out of order substrings" do
    is_perm?("fdas", "asdfa").should be_true
  end

  it "returns false on supersets with repeated characters" do
    is_perm?("asdfaa", "asdfa").should be_false
  end

  it "returns false on supersets with unique characters" do
    is_perm?("asdfaq", "asdfa").should be_false
  end

  it "returns false on a non-overlapping string" do
    is_perm?("qwer", "asdfa").should be_false
  end

  it "is not case sensative" do
    is_perm?("asdfA", "asdfa").should be_true
    is_perm?("asdfA", "asdfA").should be_true
    is_perm?("asdfa", "asdfA").should be_true
  end

end
