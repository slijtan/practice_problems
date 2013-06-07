require File.expand_path(File.dirname(__FILE__) << '/lcd.rb')

describe LCD do
  describe LCD::Screen, "#print" do
    before { @lcd = LCD::Screen.new("0123") }

    it "prints out the number at size 1" do
      result =  " _       _   _ \n"
      result << "| |   |  _|  _|\n"
      result << "|_|   | |_   _|"

      @lcd.print_display(1).should == result
    end

    it "prints out the number at size 2" do
      result =  " __        __   __ \n"
      result << "|  |    |    |    |\n"
      result << "|  |    |  __|  __|\n"
      result << "|  |    | |       |\n"
      result << "|__|    | |__   __|"

      @lcd.print_display.should == result
    end
  end

  describe LCD::Digit do
    it "tells us if we should display a line posiition" do
      digit = LCD::Digit.new(0)
      digit.display_position?(0).should be_true
      digit.display_position?(1).should be_true
      digit.display_position?(2).should be_true
      digit.display_position?(3).should be_false
      digit.display_position?(4).should be_true
      digit.display_position?(5).should be_true
      digit.display_position?(6).should be_true
    end
  end


end
