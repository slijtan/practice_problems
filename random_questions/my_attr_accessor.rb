class Object
  def self.my_attr_accessor(*args)
    args.each do |name|
      define_method(name) { instance_variable_get("@#{name}") }
      define_method("#{name}=") {|arg| instance_variable_set("@#{name}",arg)}

      class << self ; self end.class_eval do
        define_method(name) {"UNIVERSALLY HUGE #{name}"}
      end
    end
  end
end

class Lijen
  my_attr_accessor :balls, :brain
end

me = Lijen.new
p me.balls
me.balls = "huge"
p me.balls
p Lijen.balls

p me.brain
me.brain = "small"
p me.brain
p Lijen.brain
