module AnimalQuiz

  class Proctor
    def initialize(first_guess, input = STDIN, output = STDOUT)
      @first_node = Animal.new(first_guess)
      @curr_node = @first_node
      @input = input
      @output = output
    end

    def play
      @output.puts "Think of an animal...\n"
      @curr_node = @first_node

      while !@curr_node.instance_of?(Animal)
        @output.puts @curr_node.ask_question
        @curr_node = @input.gets == "y" ? @curr_node.yes : @curr_node.no
      end

      @output.puts @curr_node.ask_question
      if(@input.gets == "y")
        @output.puts "I win. Pretty smart, aren' t I?\n"
        true
      else
        @output.puts "You win. Help me learn from my mistake before you go...\n"
        false
      end
    end

    def learn
      @output.puts "What animal were you thinking of?\n"
      new_animal = @input.gets

      @output.puts "Give me a question to distinguish #{new_animal} from #{@curr_node.data}.\n"
      new_question = @input.gets

      @output.puts "For #{new_animal}, what is the answer to your question? (y or n)\n"
      new_answer = @input.gets == "y"

      @new_animal_node, @new_question_node = @curr_node.fork_node(new_animal, new_question, new_answer)
      @first_node = @new_question_node if(@curr_node == @first_node)
      @curr_node = @new_animal_node

      @output.puts "Thanks.\n"
    end

  end

  class Node
    attr_accessor :parent, :yes, :no
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def fork_node(new_leaf, new_parent, new_leaf_answer)
      new_parent = Question.new(new_parent)
      new_leaf = Animal.new(new_leaf)

      if @parent
        new_parent.parent = @parent
        @parent.replace_node(self, new_parent)
      end

      @parent = new_parent
      new_leaf.parent = new_parent

      if(new_leaf_answer)
        new_parent.yes = new_leaf
        new_parent.no = self
      else
        new_parent.yes = self
        new_parent.no = new_leaf
      end

      [new_leaf, new_parent]
    end

    def replace_node(old, new)
      @yes == old ? @yes = new : @no = new
    end
  end

  class Animal < Node
    def ask_question
      "Is it #{@data}? (y or n)\n"
    end
  end

  class Question < Node
    def ask_question
      "#{@data}\n"
    end
  end
end
