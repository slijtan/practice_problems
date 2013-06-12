#!/usr/local/ruby

require File.expand_path(File.join(File.dirname(__FILE__), 'minimum_scalar_product.rb'))

input = ARGV[0]
output = ARGV[1]

File.open(output, 'w') do |fout|

  File.open(input) do |f|
    test_cases = f.gets.chomp.to_i

    test_cases.times do |i|
      array_size = f.gets.chomp.to_i
      a = f.gets.chomp.split(" ").map(&:to_i)
      b = f.gets.chomp.split(" ").map(&:to_i)
      sum = a.min_scalar_product(b)
      fout.puts "Case ##{i+1}: #{sum}"
    end
  end

end
