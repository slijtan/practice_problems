require File.expand_path(File.dirname(__FILE__) << '/lcd.rb')

describe LCD, "#print" do
  before { @lcd = LCD.new(0123) }

  it "prints out the number at size 1" do
    @lcd.print_display(1).should == <<eos
 _        _   _
| |    |  _|  _|
|_|    | |_   _|
eos
  end

  it "prints out the number at size 2" do
    @lcd.print_display.should == <<eos
 __        __   __
|  |    |    |    |
|  |    |  __|  __|
|  |    | |       |
|__|    | |__   __|
eos
  end
end
