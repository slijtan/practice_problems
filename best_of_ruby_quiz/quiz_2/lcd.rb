module LCD
  class Screen
    def initialize(number)
      @digits = []
      number.each_char {|digit| @digits << LCD::Digit.new(digit)}
    end

    def print_display(size = 2)
      res = []
      row = 0

      #row 0
      @digits.each do |digit|
        str = " "
        if digit.display_position?(0)
          str << "_" * size
        else
          str << " " * size
        end
        str << " "

        res[row] ||= []
        res[row] << str
      end
      row += 1

      #row 1
      size.downto(1) do |i|
        @digits.each do |digit|
          str = ""
          str << (digit.display_position?(1) ? "|" : " ")
          str << (i == 1 && digit.display_position?(3) ? "_" : " ") * size #middle horizontal line
          str << (digit.display_position?(2) ? "|" : " ")

          res[row] ||= []
          res[row] << str
        end

        row += 1
      end

      #row 2
      size.downto(1) do |i|
        @digits.each do |digit|
          str = ""
          str << (digit.display_position?(4) ? "|" : " ")
          str << (i == 1 && digit.display_position?(6) ? "_" : " ") * size #bottom horizontal line
          str << (digit.display_position?(5) ? "|" : " ")

          res[row] ||= []
          res[row] << str
        end

        row += 1
      end

      res.map { |row| row.join(" ") }.join("\n")
    end
  end

  class Digit
    FILLMAP = [
               "1110111".to_i(2),
               "0100100".to_i(2),
               "1011101".to_i(2),
               "1101101".to_i(2)
              ]

    attr_reader :digit

    def initialize(digit)
      @digit = digit.to_i
    end

    def display_position?(position)
      (FILLMAP[@digit] & (1 << position)) > 0
    end

  end
end
