input = ARGV[0]
output = ARGV[1]


def check_all(array, allowed)
#  p "check all with #{array} and #{allowed}"
  array.inject(0){|sum, ele| allowed.include?(ele) ? sum + 1 : sum} == 4
end

def find_winner(vals)
  #check rows
  vals.each do |row|
    if check_all(row, ["X", "T"])
      return 0
    elsif check_all(row, ["O", "T"])
      return 1
    end
  end

  vals.transpose.each do |row|
    if check_all(row, ["X", "T"])
      return 0
    elsif check_all(row, ["O", "T"])
      return 1
    end
  end

  diags1 = (0..3).to_a.map{|i| vals[i][i]}
  diags2 = (0..3).to_a.map{|i| vals[i][3-i]}
#  p diags2

  if check_all(diags1, ["X", "T"]) || check_all(diags2, ["X", "T"])
    return 0
  elsif check_all(diags1, ["O", "T"]) || check_all(diags2, ["O", "T"])
    return 1
  end

  vals.each do |row|
    return 2 if row.include?(".")
  end

  return 3

end

File.open(output, 'w') do |fout|
  File.open(input) do |f|

    test_cases = f.gets.chomp.to_i

    1.upto(test_cases) do |c|
#      p "---TEST CASE #{c}"
      vals = []

      4.times do
        vals << f.gets.chomp.split("")
      end

      vals.each {|row| p row}

      case find_winner(vals)
      when 0
        fout.puts "Case ##{c}: X won"
        p "Case ##{c}: X won"

      when 1
        fout.puts "Case ##{c}: O won"
        p "Case ##{c}: O won"

      when 2
        fout.puts "Case ##{c}: Game has not completed"
        p "Case ##{c}: Game has not completed"

      when 3
        fout.puts "Case ##{c}: Draw"
        p "Case ##{c}: Draw"

      end

      f.gets
    end
  end
end
