=begin
https://code.google.com/codejam/contest/2270488/dashboard#s=p0

Problem

Tic-Tac-Toe-Tomek is a game played on a 4 x 4 square board. The board starts empty, except that a single 'T' symbol may appear in one of the 16 squares. There are two players: X and O. They take turns to make moves, with X starting. In each move a player puts her symbol in one of the empty squares. Player X's symbol is 'X', and player O's symbol is 'O'.

After a player's move, if there is a row, column or a diagonal containing 4 of that player's symbols, or containing 3 of her symbols and the 'T' symbol, she wins and the game ends. Otherwise the game continues with the other player's move. If all of the fields are filled with symbols and nobody won, the game ends in a draw. See the sample input for examples of various winning positions.

Given a 4 x 4 board description containing 'X', 'O', 'T' and '.' characters (where '.' represents an empty square), describing the current state of a game, determine the status of the Tic-Tac-Toe-Tomek game going on. The statuses to choose from are:

"X won" (the game is over, and X won)
"O won" (the game is over, and O won)
"Draw" (the game is over, and it ended in a draw)
"Game has not completed" (the game is not over yet)
If there are empty cells, and the game is not over, you should output "Game has not completed", even if the outcome of the game is inevitable.
Input

The first line of the input gives the number of test cases, T. T test cases follow. Each test case consists of 4 lines with 4 characters each, with each character being 'X', 'O', '.' or 'T' (quotes for clarity only). Each test case is followed by an empty line.

Output

For each test case, output one line containing "Case #x: y", where x is the case number (starting from 1) and y is one of the statuses given above. Make sure to get the statuses exactly right. When you run your code on the sample input, it should create the sample output exactly, including the "Case #1: ", the capital letter "O" rather than the number "0", and so on.
=end

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
