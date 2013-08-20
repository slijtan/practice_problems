input = ARGV[0]

dict = {}

File.open(input) do |f|
  while i = f.gets
    dict[i.to_i] = true  
  end
end

p dict.size

def sum_exists?(dict, t)
  dict.each do |x,_|
    return true if t != 2*x && dict.has_key?(t - x)
  end

  false
end

count = (-10000..10000).inject(0) do |sum, t|
  if sum_exists?(dict, t) 
    p "+"
    sum + 1
  else
    p "-"
    sum
  end
end

p count
