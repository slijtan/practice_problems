#!/usr/bin/ruby

#quick solution to problem found here
#http://discuss.leetcode.com/questions/1266/palindrome-partitioning-ii


class String
  def palindrome_cuts
    return 0 if is_palindrome?

    (1..(length - 1)).to_a.map do |i|
      left = self[0...i]
      right = self[i..-1]
      1 + left.palindrome_cuts + right.palindrome_cuts
    end.min
  end

  def is_palindrome?
    self[0...(length.to_f/2).ceil] == self[(length.to_f/2).floor..-1].split('').reverse.join
  end
end

describe String do
  describe "#is_palindrome?" do
    it "properly checks long palindromes" do
      "racecar".is_palindrome?.should be_true
    end

    it "checks even palindromes" do
      "abba".is_palindrome?.should be_true
    end

    it "properly checks 1 char palindromes" do
      "a".is_palindrome?.should be_true
    end

    it "properly checks words that arent palindromes" do
      "ab".is_palindrome?.should be_false
    end
  end

  describe "#palindrome_cuts" do
    it "counts minimum cuts to form all palindromes" do
      "aab".palindrome_cuts.should == 1
      "racecaraabba".palindrome_cuts.should == 2
      "racecarabba".palindrome_cuts.should == 1
      "aracecarbc".palindrome_cuts.should == 3
    end
  end
end
