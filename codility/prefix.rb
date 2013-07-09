def solution(s)
  # p "solution of #{s}"
  borders = []
  (0..(s.length/3-1)).each do |i|
    # p "checking " + s[0..i] + " VS " + s[(-1*i - 1)..-1]
    borders << s[0..i] if s[0..i] == s[(-1*i - 1)..-1]
  end

  # p borders

  while borders.size > 0
    candidate = borders.pop
    # p "searching " + s[candidate.length..(-1 * candidate.length - 1)] + " for " + candidate
    return candidate.size if s[candidate.length..(-1 * candidate.length - 1)].index(candidate)
  end

  0
end


describe "solution" do
  it "handles all my test cases" do
    solution('barbararhubarb').should == 1
    solution('ababab').should == 2
    solution('').should == 0
    solution('a').should == 0
    solution('aa').should == 0
    solution('aaa').should == 1
    solution('aaaa').should == 1
    solution('aaaaa').should == 1
    solution('aaaaaa').should == 2

    solution('ababa').should == 1
    solution('abababa').should == 1
    solution('abababab').should == 2
    solution('ababababa').should == 1
    solution('ababababab').should == 2
    solution('abababababa').should == 3

    solution('aabbbbaa').should == 1
    solution('aaabbbbaa').should == 1
    solution('aaaabbbbaa').should == 2

    solution('aabbaa').should == 1
    solution('aababaa').should == 1
    solution('aabaabaa').should == 2

    solution('bab').should == 0
    solution('babb').should == 1

    solution('asdfasadfasdfasfdsasdfas').should == 6
  end
end
