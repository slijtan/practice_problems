class Array

  def pairs_that_add_up_to(sum)
    raise ArgumentError.new("array must contain at least 2 elements") if size < 2

    #preprocess array
    existing_ints_lookup = self.inject(Hash.new(0)) {|int_hash, i| int_hash[i] += 1; int_hash; }

    selected = []
    self.each do |ele|
      compliment = sum - ele

      if existing_ints_lookup[ele] > 0
        existing_ints_lookup[ele] -= 1

        if existing_ints_lookup[compliment] > 0
          existing_ints_lookup[compliment] -= 1

          selected << [ele, compliment]
        end
      end
    end

    selected
  end

end
