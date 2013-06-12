=begin
problem: https://code.google.com/codejam/contest/32016/dashboard#s=p1
sol: http://www.go-hero.net/jam/08/solutions/1/2/Ruby

Problem

You own a milkshake shop. There are N different flavors that you can prepare, and each flavor can be prepared "malted" or "unmalted". So, you can make 2N different types of milkshakes.

Each of your customers has a set of milkshake types that they like, and they will be satisfied if you have at least one of those types prepared. At most one of the types a customer likes will be a "malted" flavor.

You want to make N batches of milkshakes, so that:

There is exactly one batch for each flavor of milkshake, and it is either malted or unmalted.
For each customer, you make at least one milkshake type that they like.
The minimum possible number of batches are malted.
Find whether it is possible to satisfy all your customers given these constraints, and if it is, what milkshake types you should make.
If it is possible to satisfy all your customers, there will be only one answer which minimizes the number of malted batches.
=end


class MilkshakeShop
  def initialize(num_flavors, memoize = false)
    @num_flavors = num_flavors
    @memoize = memoize ? {} : false
  end

  def make_milkshakes(customers)
    if res = make_milkshakes_rec(customers)
      res.map{|ele| ele.nil? ? 0 : ele}
    end
  end

  def make_milkshakes_rec(customers, flavors_used = [])
    return flavors_used if customers.empty?

    if @memoize
      key = customers.map{|c|c.id}.join("_") << flavors_used.join("_")
      return @memoize[key] if @memoize[key]
    end

    customer = customers.shift

    possible_flavors_used = []
    customer.preferences.each do |preference|
      if can_make_milkshake?(preference, flavors_used) &&
          flavors_used = make_milkshakes_rec(customers.clone, use_flavor(preference, flavors_used))

        possible_flavors_used << flavors_used
      end
    end

    if possible_flavors_used.empty?
      false
    else
      best = most_efficient(possible_flavors_used)
      @memoize[key] = best if @memoize
      best
    end
  end

  def can_make_milkshake?(preference, flavors_used)
    flavors_used[preference[0]-1].nil?
  end

  def use_flavor(preference, flavors_used)
    flavor, malted = preference[0], preference[1]

    clone = flavors_used.clone
    clone[flavor-1] = malted
    clone
  end

  def most_efficient(possible_flavors_used)
    min_sum = @num_flavors + 1
    min_ele = nil
    possible_flavors_used.each do |flavors_used|
      min_ele = flavors_used if flavors_used.inject{|sum, num| sum + (num.nil? ? 0 : num) } < min_sum
    end

    min_ele
  end

  class Customer
    attr_reader :preferences, :id
    @@id = 0

    def initialize(preferences)
      @preferences = preferences
      @id = @@id += 1
    end
  end
end
