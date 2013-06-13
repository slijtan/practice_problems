=begin
question: https://code.google.com/codejam/contest/90101/dashboard#s=p2
solutions: http://www.go-hero.net/jam/09/solutions/0/3/Ruby

Problem

So you've registered. We sent you a welcoming email, to welcome you to code jam. But it's possible that you still don't feel welcomed to code jam. That's why we decided to name a problem "welcome to code jam." After solving this problem, we hope that you'll feel very welcome. Very welcome, that is, to code jam.

If you read the previous paragraph, you're probably wondering why it's there. But if you read it very carefully, you might notice that we have written the words "welcome to code jam" several times: 400263727 times in total. After all, it's easy to look through the paragraph and find a 'w'; then find an 'e' later in the paragraph; then find an 'l' after that, and so on. Your task is to write a program that can take any text and print out how many times that text contains the phrase "welcome to code jam".

To be more precise, given a text string, you are to determine how many times the string "welcome to code jam" appears as a sub-sequence of that string. In other words, find a sequence s of increasing indices into the input string such that the concatenation of input[s[0]], input[s[1]], ..., input[s[18]] is the string "welcome to code jam".

The result of your calculation might be huge, so for convenience we would only like you to find the last 4 digits.
=end

class String
  @@store = {}

  #recursive with memoization
  def count_substrings_rec(needle)
    return 1 if needle == ""

    key = "#{self}_#{needle}"
    return @@store[key] if @@store[key]

    first_letter = needle[0]
    rest_of_needle = needle[1..-1]
    count = 0
    #p "#{first_letter} | #{rest_of_needle}"

    (0 .. self.length - 1).find_all { |i| self[i,1] == first_letter }.each do |i|
      substr = self[(i+1)..-1]
      count += substr.count_substrings_rec(rest_of_needle)
    end

    @@store[key] = count
    count
  end

  #DP
  def count_substrings(needle)
    #load lookups
    letter_positions = Hash.new {|h,k| h[k] = []}
    counts = [0] * needle.length

    0.upto(needle.length - 1) do |i|
      letter_positions[needle[i]] << i
    end

    each_char do |char|
      letter_positions[char].each do |position|
        if position == 0
          counts[position] += 1
        else
          counts[position] += counts[position-1]
        end
      end
    end

    counts.last
  end
end
