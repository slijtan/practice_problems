#!/usr/local/ruby

require File.expand_path(File.join(File.dirname(__FILE__), 'milkshakes.rb'))

input = ARGV[0]
output = ARGV[1]

File.open(output, 'w') do |fout|

  File.open(input) do |f|
    test_cases = f.gets.chomp.to_i

    test_cases.times do |i|
      p "---------"
      num_flavors = f.gets.chomp.to_i
      customer_count = f.gets.chomp.to_i
      customers = []
      customer_count.times do
        customer_data = f.gets.chomp.split(" ").map(&:to_i)
        p "customer-> " << customer_data.join(" ")
        num_preferences = customer_data.shift
        preferences = []
        num_preferences.times do
          preferences << [customer_data.shift, customer_data.shift]
        end
        customers << MilkshakeShop::Customer.new(preferences)
      end

      p "trying with #{customer_count} customers and #{num_flavors} flavors"

      if res = MilkshakeShop.new(num_flavors, true).make_milkshakes(customers)
        fout.puts "Case ##{i+1}: #{res.join(' ')}"
        p "Case ##{i+1}: #{res.join(' ')}"
      else
        fout.puts "Case ##{i+1}: IMPOSSIBLE"
        p "Case ##{i+1}: IMPOSSIBLE"
      end
    end
  end
end
