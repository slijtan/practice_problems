module MadLib
  class Storyteller
    def initialize(story_template, input = STDIN, output = STDOUT)
      @story = Story.new(story_template, input, output)
    end

    def tell_story
      @story.word_spaces do |word_space|
        word_replacement = @story.get_word_replacement(word_space)
        @story.place_word(word_space, word_replacement)
      end

      return @story.story

      while match_data = story.match(/(\(\((.+?)\)\))/)
        word_space = match_data[2]
        start, finish = match_data.offset(1)
        var_name = nil

        if(word_parts = MadLib::Storyteller.should_store_word?(word_space))
          var_name, word_space = word_parts
        end

        unless(user_word = stored_words[word_space])
          output.puts "Please provide #{word_space}"
          user_word = input.gets
        end

        story[start...finish] = user_word

        stored_words[var_name] = user_word if var_name
      end

      story
    end

    private

    def self.should_store_word?(word)
      if (match = word.match(/(.+):(.+)/))
        return [match[1], match[2]]
      end
    end
  end

  class Story
    attr_reader :story

    def initialize(story_template, input, output)
      @story_template = story_template
      @story = story_template
      @input = input
      @output = output
      @stored_words = {}
    end

    def word_spaces(&block)
      while match_data = @story.match(/(\(\((.+?)\)\))/)
        word_name = match_data[2]
        start, finish = match_data.offset(1)
        yield WordSpace.new(word_name, start, finish)
      end
    end

    def get_word_replacement(word_space)
      if @stored_words[word_space.name]
        word_replacement = @stored_words[word_space.name]
      else
        @output.puts "Please provide #{word_space.name}"
        word_replacement = @input.gets

        @stored_words[word_space.var_name] = word_replacement if word_space.is_set_repeating?
      end

      word_replacement
    end

    def place_word(word_space, word_replacement)
      @story[word_space.start...word_space.finish] = word_replacement
    end
  end

  class WordSpace
    attr_reader :name, :start, :finish, :var_name

    def initialize(name, start, finish)
      if (match = name.match(/(.+):(.+)/))
        @var_name = match[1]
        @name = match[2]
      else
        @name = name
      end

      @start = start
      @finish = finish
    end

    def is_set_repeating?
      !!@var_name
    end
  end

end
