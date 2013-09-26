class CreditCard

  VALID = 0
  ERROR_INVALID_LENGTH = 1
  ERROR_INVALID_CARD_TYPE = 2
  ERROR_LUHN_CHECK = 3

  def initialize(number)
    @number = number.to_s
  end

  def validate
    errors = []

    errors << ERROR_INVALID_LENGTH if @number.length < 13 || @number.length > 16
    errors << ERROR_INVALID_CARD_TYPE unless @number =~ /^4|5|6|37\d*/

    sum = 0
    @number.reverse.each_char.with_index do |num, index|
      if index % 2 == 1
        num = num.to_i*2
        num -= 9 if num > 9
      end

      sum += num.to_i
    end

    errors << ERROR_LUHN_CHECK unless sum % 10 == 0

    errors
  end
end
