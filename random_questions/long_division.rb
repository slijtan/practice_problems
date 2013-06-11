Integer.class_eval do
  def long_division(denom)
    first, rest = self.remove_sig_digit
    res = denom.long_division_recursive(first, rest)
    res = res.gsub(/^0/, '') unless res =~ /^0\./
    res
  end

  protected

  def long_division_recursive(num, remaining_digits, decimal_found = false)
    div, mod = num.divmod(self)
    if remaining_digits.nil?
      remaining_first, remaining_rest = 0, nil
    else
      remaining_first, remaining_rest = remaining_digits.remove_sig_digit
    end
    new_num = mod * 10 + remaining_first

    if(remaining_digits.nil? && !decimal_found) #add a decimal on first time we get past digits
      show_decimal = true
      decimal_found = true
    end

    if num == 0 && remaining_digits.nil? #base case
      return ""
    elsif(num == new_num && remaining_rest.nil?) #repeating digit past decimal
      str = "(#{div})"
    else
      str = div.to_s
      remaining = long_division_recursive(new_num, remaining_rest, decimal_found)
      unless remaining.empty?
        str << "." if show_decimal
        str << remaining
      end
    end

    str
  end

  #returns [first digit, rest of digits <nil if none>]
  def remove_sig_digit
    return [self, nil] if self < 10

    return [self.to_s[0].to_i, self.to_s[1..-1].to_i]
  end
end


describe Integer, "#long_division" do
  it "properly divides that are factors of each other" do
    4.long_division(2).should == "2"
  end

  it "properly divides numbers that result in a decimal" do
    6.long_division(4).should == "1.5"
  end

  it "displays repeating decimals in parenthesis" do
    4.long_division(3).should == "1.(3)"
  end

  it "displays at least one digit to the left of the decimal" do
    2.long_division(3).should == "0.(6)"
  end

  it "doesnt display leading zeros" do
    2345.long_division(3).should == "781.(6)"
  end
end
