=begin
This was a question that tony got from asana.
- Please set aside 30 minutes to answer this question. No need to feel rushed, but we do want to make sure you can answer the question in a reasonably short amount of time.
- Please do not compile/run your code. The problem is designed to test your ability to track details, catch off-by-ones, and address corner cases. A run-test-run-test cycle would defeat a lot of the question's value. Of course, in real life you would be able to test, but in real life you'd be dealing with much more complicated problems, and we can't simulate those situations in a half hour, so removing the ability to test your code provides a simulation.
- You are welcome to use your text editor of choice, and then paste the results into the text box on the next page.
- Please use C, C++, Java, JavaScript, Python or Ruby for your solution.
- We recommend against trying overly clever solutions or aiming to finish early, feel free to take the full time to confirm correctness and and write something that works.
- In the event that you are not finished at the 30 minute mark, please send us what you have completed regardless. If you feel inclined, you are then welcome to send a final solution via email as soon as possible, indicating how much extra time you have taken to come to the final solution.
=end

#Given a matrix, print it out in a spiral format

# For example, given a matrix like this as input:
#
# [[11, 12, 13, 14, 15],
# [21, 22, 23, 24, 25],
# [31, 32, 33, 34, 35],
# [41, 42, 43, 44, 45]]
# Your program must print:
#
# 11 12 13 14 15 25 35 45 44 43 42 41 31 21 22 23 24 34 33 32

class Array
  DIRECTION_RIGHT = 0
  DIRECTION_DOWN = 1
  DIRECTION_LEFT = 2
  DIRECTION_UP = 3

  def print_spiral
    print_sequence(DIRECTION_RIGHT, self.clone)
  end

  private

  def print_sequence(direction, matrix)
    case direction
    when DIRECTION_RIGHT
      print matrix.shift.join(" ")

    when DIRECTION_DOWN
      print matrix.map { |row| row.pop }.join(" ")
      compress_matrix(matrix)

    when DIRECTION_LEFT
      print matrix.pop.reverse.join(" ")

    when DIRECTION_UP
      print matrix.reverse.map { |row| row.shift }.join(" ")
      compress_matrix(matrix)
    end

    unless matrix.size == 0
      print " "
      print_sequence(next_direction(direction), matrix)
    end
  end

  def next_direction(direction)
    (direction + 1) % 4
  end

  def compress_matrix(matrix)
    matrix.delete_if {|row| row.size == 0 }
  end
end

[[11, 12, 13, 14, 15],
 [21, 22, 23, 24, 25],
 [31, 32, 33, 34, 35],
 [41, 42, 43, 44, 45]].print_spiral
