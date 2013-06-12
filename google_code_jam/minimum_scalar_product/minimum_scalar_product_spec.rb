require File.expand_path(File.join(File.dirname(__FILE__), 'minimum_scalar_product.rb'))

describe Array "#min_scalar_product" do
  it "solves googles first example" do
    [1, 3, -5].min_scalar_product([-2, 4, 1]).should == -25
  end

  it "solves googles second example" do
    [1, 2, 3, 4, 5].min_scalar_product([1, 0, 1, 0, 1]).should == 6
  end
end
