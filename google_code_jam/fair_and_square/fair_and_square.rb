=begin
question: https://code.google.com/codejam/contest/2270488/dashboard#s=p2
solutions: http://www.go-hero.net/jam/13/solutions/0/3/Ruby
explanation for optimal result: http://tavianator.com/2013/04/fair-and-square-or-how-to-count-to-a-googol/

Problem

Little John likes palindromes, and thinks them to be fair (which is a fancy word for nice). A palindrome is just an integer that reads the same backwards and forwards - so 6, 11 and 121 are all palindromes, while 10, 12, 223 and 2244 are not (even though 010=10, we don't consider leading zeroes when determining whether a number is a palindrome).

He recently became interested in squares as well, and formed the definition of a fair and square number - it is a number that is a palindrome and the square of a palindrome at the same time. For instance, 1, 9 and 121 are fair and square (being palindromes and squares, respectively, of 1, 3 and 11), while 16, 22 and 676 are not fair and square: 16 is not a palindrome, 22 is not a square, and while 676 is a palindrome and a square number, it is the square of 26, which is not a palindrome.

Now he wants to search for bigger fair and square numbers. Your task is, given an interval Little John is searching through, to tell him how many fair and square numbers are there in the interval, so he knows when he has found them all.

Solving this problem

Usually, Google Code Jam problems have 1 Small input and 1 Large input. This problem has 1 Small input and 2 Large inputs. Once you have solved the Small input, you will be able to download any of the two Large inputs. As usual, you will be able to retry the Small input (with a time penalty), while you will get only one chance at each of the Large inputs.

Input

The first line of the input gives the number of test cases, T. T lines follow. Each line contains two integers, A and B - the endpoints of the interval Little John is looking at.

Output

For each test case, output one line containing "Case #x: y", where x is the case number (starting from 1) and y is the number of fair and square numbers greater than or equal to A and smaller than or equal to B.
=end

input = ARGV[0]
output = ARGV[1]

$palindromes = {}

def is_palindrome?(num)
  return true if num < 10

  num = num.to_s
  return $palindromes[num] unless $palindromes[num].nil?

  (0..(num.length/2-1)).each do |i|
#    p "comparing #{num[i]} to #{num[num.length-1-i]}"
    unless num[i] == num[num.length-1-i]
      $palindromes[num] = false
      return $palindromes[num]
#      return false
    end
  end

  $palindromes[num] = true
  return $palindromes[num]
#  return true
end

def next_palindrome(num)
  if num < 9
    num + 1
  else
    num = num.to_s
    left = num[0...(num.length+1)/2]
    is_odd = num.length.odd?

    new_left = (left.to_i + 1).to_s
    new_right = new_left.split('').reverse.join
    new_left = new_left[0..-2]     if left == "9"*left.length
    new_right = new_right[1..-1] if is_odd
    (new_left + new_right).to_i
  end
end

def initialize_palindrome(num)
  loop do
    return num if is_palindrome?(num)
    num += 1
  end
end

i = 989
while i < 1000
  i = next_palindrome(i)
#  p i
end

File.open(output, 'w') do |fout|
  File.open(input) do |f|

    test_cases = f.gets.chomp.to_i

    1.upto(test_cases) do |c|
      min, max = f.gets.chomp.split(" ").map(&:to_i)
#      p "---TEST CASE #{c} #{min} #{max}"

      num = initialize_palindrome(Math.sqrt(min).ceil)
#      p num

      count = 0
      while num*num <= max
#        p "trying #{num}"
        count += 1 if is_palindrome?(num*num)
        num = next_palindrome(num)
      end

      fout.puts "Case ##{c}: #{count}"
      p "Case ##{c}: #{count}"
    end
  end
end
