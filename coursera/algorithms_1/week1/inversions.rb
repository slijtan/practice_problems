#!/usr/local/ruby

input = ARGV[0]
a = []

File.open(input) do |f|
  while i = f.gets
    a << i.chomp.to_i
  end
end

p a.size
