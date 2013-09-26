#Fahrenheit = Celsius * (9 / 5) + 32

def fahrenheit(celsius)
  celsius * (9/5) + 32
end

def fahrenheit(celsius)
  celsius * (9.0/5) + 32
end

def fib(n)
  return if n < 0
  puts "0"
  return if n == 0
  puts "1"

  n_minus_two = 0
  n_minus_one = 1

  (2..n).each do |i|
    n_minus_two, n_minus_one = n_minus_one, n_minus_two + n_minus_one
    puts n_minus_one
  end
end

|\
| \
|  \
|   \
|    \
|_____\


def ascii_triangle(height)
  return if height == 0

  (0...height-1).each do |spaces|
    puts "|#{' '*spaces}\\"
  end

  puts "|#{'_'*(height-1)}\\"
end

def all_words(keystrokes)
  first_key = keystrokes.shift
  all_possible_strings_without_first_key = all_words(keystrokes)
  results = []
  foreach possible_letter from first_key
    foreach possible_result in all_possible_strings_without_first_key
      results << first_key + possible_result
    end
  end

  return results
end



def fl(h)
  p h.to_a.flatten.sort
end

fl({'a' => 1, 'c'=> {'d'=> {'e'=> 4}}, 'b'=> {'a'=> 2, 'b'=> 3}})
