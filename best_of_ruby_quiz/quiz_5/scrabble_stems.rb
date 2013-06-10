class Dictionary
  def initialize(dict_array)
    @dictionary = dict_array
  end

  def scrabble_stems(cutoff)
    words_from_letters = Hash.new {|h, k| h[k] = []}
    solution_set = []

    @dictionary.each do |word|
      next unless word.length == 7

      key = word.sort
      0.upto(key.length-1) do |i|
        sub_hash = key[0...i] + key[(i+1)..(key.length-1)]

        unless words_from_letters[sub_hash].include?(word)
          words_from_letters[sub_hash] << word
          solution_set << sub_hash if words_from_letters[sub_hash].size == cutoff
        end
      end
    end

    solution_set
  end

end

class String
  include Enumerable

  alias_method :each, :each_char

  def sort
    super.join
  end
end
