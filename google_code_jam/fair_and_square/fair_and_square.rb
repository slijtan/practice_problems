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
