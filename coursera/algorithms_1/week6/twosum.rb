input = ARGV[0]

dict_pos = {}
dict_neg = {}

File.open(input) do |f|
  while i = f.gets
    if i.to_i >= 0
      dict_pos[i.to_i] = true
    else
      dict_neg[i.to_i] = true
    end      
  end
end

def sum_exists?(dict_pos, dict_neg, t)
  dict_pos.each do |x,_|
    return true if dict_neg.has_key?(t - x)
  end

  false
end

count = (-10000..10000).inject(0) do |sum, t|
  p t
  if sum_exists?(dict_pos, dict_neg, t) 
    p "+"
    sum + 1
  else
    p "-"
    sum
  end
end

p count
