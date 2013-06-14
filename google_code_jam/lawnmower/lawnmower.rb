input = ARGV[0]
output = ARGV[1]

def check_height(h, lawn, n, m, counts)
  #p "checking height #{h}"
  #lawn.each {|r| p r}
  #p counts

  found = []
  lawn.each_with_index do |row, i|
    if row == [h] * m
#      p "found row #{i}"
      found[i*m..(i+1)*m] = [h] * m
    end
  end
  lawn.transpose.each_with_index do |col, i|
    if col == [h] * n
#      p "found col #{i}"
      0.upto(n-1) do |row|
        found[i + row*m] = h
      end
    end
  end

  #p "found for #{h}"
  #p found

  if found.compact.size == counts[h]
    #p "this height clears"
    return true
  else
    #p "this height is wak"
    return false
  end
end

def replace_heights(old, new, lawn)
  lawn.each do |row|
    row.map! {|ele| ele == old ? new : ele}
  end
end

File.open(output, 'w') do |fout|
  File.open(input) do |f|

    test_cases = f.gets.chomp.to_i

    1.upto(test_cases) do |c|
#      p "---TEST CASE #{c}"
      n, m = f.gets.chomp.split(" ").map(&:to_i)
      lawn = []

      n.times do
        lawn << f.gets.chomp.split(" ").map(&:to_i)
      end

      lawn.each {|r| p r}

      heights = lawn.flatten.uniq.sort
      counts = Hash.new {|h,k| h[k] = 0}
      possible = true

      lawn.each do |row|
        row.each do |ele|
          counts[ele] += 1
        end
      end

      #p heights
      #p counts

      while h = heights.shift and possible
        if check_height(h, lawn, n, m, counts)
          replace_heights(h, heights.first, lawn)
          counts[h], counts[heights.first] = 0, counts[h] + counts[heights.first]
        else
          possible = false
        end
      end

      if possible
        fout.puts "Case ##{c}: YES"
        p "Case ##{c}: YES"
      else
        fout.puts "Case ##{c}: NO"
        p "Case ##{c}: NO"
      end
    end
  end
end
