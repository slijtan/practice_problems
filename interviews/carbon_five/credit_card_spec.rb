require File.expand_path(File.join(File.dirname(__FILE__), "credit_card"))

describe CreditCard do

  context "for a valid credit card" do
    it "should have between 13 and 16 digits" do
      cc = CreditCard.new(41111111111111)
      cc.validate.should_not include(CreditCard::ERROR_INVALID_LENGTH)

      cc = CreditCard.new(4111111111111111)
      cc.validate.should_not include(CreditCard::ERROR_INVALID_LENGTH)
    end

    it "should start with a 4, 5, 37, or 6 for valid card types" do
      cc = CreditCard.new(4)
      cc.validate.should_not include(CreditCard::ERROR_INVALID_CARD_TYPE)

      cc = CreditCard.new(5111111)
      cc.validate.should_not include(CreditCard::ERROR_INVALID_CARD_TYPE)

      cc = CreditCard.new(371111111111111)
      cc.validate.should_not include(CreditCard::ERROR_INVALID_CARD_TYPE)

      cc = CreditCard.new(6111111111111111)
      cc.validate.should_not include(CreditCard::ERROR_INVALID_CARD_TYPE)
    end

    it "should pass the Luhn check" do
      cc = CreditCard.new(26)
      cc.validate.should_not include(CreditCard::ERROR_LUHN_CHECK)

      cc = CreditCard.new(76372)
      cc.validate.should_not include(CreditCard::ERROR_LUHN_CHECK)
    end

    it "should pass all tests" do
      cc = CreditCard.new(4111111111111111)
      cc.validate.should be_empty

      cc = CreditCard.new(4388576054740298)
      cc.validate.should be_empty
    end
  end

  context "for an invalid credit card" do
    it "should fail the length check" do
      cc = CreditCard.new(411111111111)
      cc.validate.should include(CreditCard::ERROR_INVALID_LENGTH)

      cc = CreditCard.new(41111111111111111)
      cc.validate.should include(CreditCard::ERROR_INVALID_LENGTH)
    end

    it "should fail the valid card type check" do
      cc = CreditCard.new(1)
      cc.validate.should include(CreditCard::ERROR_INVALID_CARD_TYPE)

      cc = CreditCard.new(211111111111111)
      cc.validate.should include(CreditCard::ERROR_INVALID_CARD_TYPE)
    end

    it "should fail the Luhn check" do
      cc = CreditCard.new(27)
      cc.validate.should include(CreditCard::ERROR_LUHN_CHECK)

      cc = CreditCard.new(76373)
      cc.validate.should include(CreditCard::ERROR_LUHN_CHECK)
    end
  end
end
