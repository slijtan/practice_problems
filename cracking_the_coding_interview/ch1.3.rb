def is_perm?(str1, str2)
  str1 = str1.downcase
  str2 = str2.downcase
  letter_count = Array.new

  str2.each_char do |char|
    index = char.ord - 'a'.ord
    letter_count[index] = letter_count[index] ? letter_count[index] + 1 : 1
  end

  str1.each_char do |char|
    index = char.ord - 'a'.ord
    if letter_count[index] && letter_count[index] > 0
      letter_count[index] -= 1
    else
      return false
    end
  end

  true
end

str1 = "asfd"
str2 = "asdfa"
p is_perm?(str1, str2)
p "str1 and 2 #{str1}, #{str2}"

str1 = "xfd"
p is_perm?(str1, str2)
p "str1 and 2 #{str1}, #{str2}"

str1 = "fdas"
p is_perm?(str1, str2)
p "str1 and 2 #{str1}, #{str2}"

str1 = "asdfaa"
p is_perm?(str1, str2)
p "str1 and 2 #{str1}, #{str2}"

str1 = "asdfA"
p is_perm?(str1, str2)
p "str1 and 2 #{str1}, #{str2}"

str1 = "asdfAa"
p is_perm?(str1, str2)
p "str1 and 2 #{str1}, #{str2}"
