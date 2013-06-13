#!/usr/local/ruby

require File.expand_path(File.join(File.dirname(__FILE__), 'welcome_to_codejam.rb'))

input = ARGV[0]
output = ARGV[1]


def last_four(num)
  str = num.to_s
  if str.length > 4
    str[-4..-1]
  else
    while str.length < 4
      str = "0#{str}"
    end
    str
  end
end

File.open(output, 'w') do |fout|
  File.open(input) do |f|
    test_cases = f.gets.chomp.to_i

    test_cases.times do |i|
      res = f.gets.chomp.count_substrings_rec("welcome to code jam")
      result = last_four(res)

      p "Case ##{i+1}: #{result} #{res}"
      fout.puts "Case ##{i+1}: #{result}"
    end
  end
end
