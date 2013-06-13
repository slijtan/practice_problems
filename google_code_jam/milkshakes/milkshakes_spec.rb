require File.expand_path(File.join(File.dirname(__FILE__), 'milkshakes.rb'))

describe MilkshakeShop do
=begin
  it "solves googles first example" do
    shop = MilkshakeShop.new(5)
    customers = []
    customers << MilkshakeShop::Customer.new([[1, 1]])
    customers << MilkshakeShop::Customer.new([[1, 0], [2, 0]])
    customers << MilkshakeShop::Customer.new([[5, 0]])

    shop.make_milkshakes(customers).should == [1, 0, 0, 0, 0]
  end

  it "solves googles second example" do
    shop = MilkshakeShop.new(1)
    customers = []
    customers << MilkshakeShop::Customer.new([[1, 0]])
    customers << MilkshakeShop::Customer.new([[1, 1]])

    shop.make_milkshakes(customers).should be_false
  end
=end

  it "solves googles third example" do
    shop = MilkshakeShop.new(1)
    customers = []
    customers << MilkshakeShop::Customer.new([[1, 1]])
    customers << MilkshakeShop::Customer.new([[1, 1]])
    customers << MilkshakeShop::Customer.new([[1, 1]])

    shop.make_milkshakes(customers).should == [1]
  end
end
