class Array
  def size_of_longest_made_of_others
    dict = self.inject({}) {|h,k| h[k] = true; h}
    words_by_size = sort {|a,b|a.length <=> b.length}.reverse

    words_by_size.each do |word|
      return word if lookup_parts(word, dict)
    end

    nil
  end

  private

  def lookup_parts(word, dict)
    0.upto(word.length-1) do |i|
      return true if dict[word[0..i]] && dict[word[(i+1)..(word.length-1)]]
    end

    false
  end
end
