#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), 'scrabble_stems.rb'))

dictionary_file = ARGV[0]
cutoff = ARGV[1].to_i

p "running with dictionary file: #{dictionary_file} and cutoff: #{cutoff}"
tokens = []

File.open(dictionary_file) do |f|
  f.each do |line|
    tokens << line.chomp!
  end
end

dictionary = Dictionary.new(tokens)
stems = dictionary.scrabble_stems(cutoff)

p stems
p "#{stems.size} stems found..."
