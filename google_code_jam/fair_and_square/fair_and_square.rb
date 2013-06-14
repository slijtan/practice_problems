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
      return $palindromes[num] = false
    end
  end

  $palindromes[num] = true
end

File.open(output, 'w') do |fout|
  File.open(input) do |f|

    test_cases = f.gets.chomp.to_i

    1.upto(test_cases) do |c|
#      next unless c == 12

      min, max = f.gets.chomp.split(" ").map(&:to_i)
      p "---TEST CASE #{c} #{min} #{max}"

      num = Math.sqrt(min).ceil
      count = 0
      while num*num <= max
#        p "trying #{num*num}"
        count += 1 if is_palindrome?(num) && is_palindrome?(num*num)
        num += 1
      end

      fout.puts "Case ##{c}: #{count}"
      p "Case ##{c}: #{count}"

    end
  end
end
